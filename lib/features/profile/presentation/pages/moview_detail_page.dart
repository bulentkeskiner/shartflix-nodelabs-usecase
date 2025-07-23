import 'package:flutter/material.dart';
import 'package:shartflix/core/components/image/network_image.dart';
import 'package:shartflix/core/theme/constants/app_colors.dart';
import 'package:shartflix/di_helper.dart';
import 'package:shartflix/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shartflix/features/discover/presentation/bloc/discover_event.dart';
import 'package:shartflix/models/movie_model.dart';
import 'package:shartflix/support/app_lang.dart';

class MovieDetailPage extends StatefulWidget {
  final MovieModel? movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  bool _isWatchlist = false;

  late MovieModel movie;

  @override
  void initState() {
    super.initState();

    if (widget.movie == null) {
      Navigator.pop(context);
      return;
    }

    movie = widget.movie!;

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut));

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary, AppColors.background, AppColors.background],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMovieInfo(),
                      _buildActionButtons(),
                      _buildStatsRow(),
                      _buildPlotSection(),
                      _buildCastSection(),
                      _buildDetailsSection(),
                      _buildImageGallery(),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    var postOriginalUrl = movie.poster ?? "";
    String correctedUrl = postOriginalUrl.replaceFirst(
      "http://ia.media-imdb.com",
      "https://images-na.ssl-images-amazon.com",
    );
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: Colors.transparent,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(25),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            AppNetworkImage(
              imageUrl: correctedUrl,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return Container(
                  color: Colors.grey[800],
                  child: const Icon(Icons.movie, size: 100, color: Colors.white54),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieInfo() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Text(
              movie.title ?? '',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  movie.year ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white54),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  movie.rated ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.access_time, color: Colors.white54, size: 16),
              const SizedBox(width: 4),
              Text(
                movie.runtime ?? '',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            movie.genre ?? '',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
                label: Text(
                  lang(LocaleKeys.play),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildActionButton(
            icon: movie.isFavorite == true ? Icons.favorite : Icons.favorite_border,
            onPressed: () => toggleFavorite(),
            color: movie.isFavorite == true ? AppColors.white : Colors.white,
          ),
          const SizedBox(width: 8),
          _buildActionButton(
            icon: _isWatchlist ? Icons.check : Icons.add,
            onPressed: () {
              _isWatchlist = !_isWatchlist;
              setState(() {});
            },
            color: _isWatchlist ? Colors.green : Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return AnimatedScale(
      scale: 1.0,
      duration: const Duration(milliseconds: 100),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: color),
          iconSize: 24,
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            lang(LocaleKeys.imdbRating),
            movie.imdbRating ?? '0.0',
            Icons.star,
            Colors.amber,
          ),
          _buildStatItem(
            lang(LocaleKeys.imdbScore),
            movie.metascore ?? '0',
            Icons.analytics,
            Colors.green,
          ),
          _buildStatItem(
            lang(LocaleKeys.imdbVotes),
            _formatVotes(movie.imdbVotes ?? '0'),
            Icons.people,
            Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildPlotSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lang(LocaleKeys.plot),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            movie.plot ?? '',
            style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildCastSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lang(LocaleKeys.cast),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            movie.actors ?? '',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lang(LocaleKeys.details),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(lang(LocaleKeys.director), movie.director ?? ''),
          _buildDetailRow(lang(LocaleKeys.writer), movie.writer ?? ''),
          _buildDetailRow(lang(LocaleKeys.releaseDate), movie.released ?? ''),
          _buildDetailRow(lang(LocaleKeys.language), movie.language ?? ''),
          _buildDetailRow(lang(LocaleKeys.country), movie.country ?? ''),
          if (movie.awards != null && movie.awards!.isNotEmpty)
            _buildDetailRow(lang(LocaleKeys.awards), movie.awards!),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery() {
    if (movie.images == null || movie.images!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            lang(LocaleKeys.gallery),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: movie.images!.length,
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300 + (index * 100)),
                margin: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    movie.images![index],
                    width: 160,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 160,
                        height: 120,
                        color: Colors.grey[800],
                        child: const Icon(Icons.image, color: Colors.white54),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatVotes(String votes) {
    final numVotes = votes.replaceAll(',', '');
    final number = int.tryParse(numVotes) ?? 0;

    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  // MARK: Actions
  void toggleFavorite() {
    var id = movie.id;
    if (id == null) return;

    sl<DiscoverBloc>().add(DiscoverToggleFavorite(id));

    // Api eksik olduğu için isFavorite model içinden güncelleniyor.
    // Api implementasyonu olsaydı, güncel modeli server'dan almak gerekirdi.
    movie.isFavorite = !movie.isFavorite!;
    setState(() {});
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }
}
