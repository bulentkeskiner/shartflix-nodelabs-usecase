import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shartflix/core/components/shimmer_place_holder.dart';
import 'package:shartflix/core/components/text/readmore.dart';
import 'package:shartflix/core/theme/constants/app_colors.dart';
import 'package:shartflix/models/movie_model.dart';
import 'package:shartflix/support/app_lang.dart';

class DiscoverItem extends StatefulWidget {
  final MovieModel model;
  final Function(String id)? onFavoriteTab;

  const DiscoverItem({super.key, required this.model, this.onFavoriteTab});

  @override
  State<DiscoverItem> createState() => _DiscoverItemState();
}

class _DiscoverItemState extends State<DiscoverItem> with TickerProviderStateMixin {
  late AnimationController _favoriteController;
  late AnimationController _pulseController;
  late AnimationController _bounceController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<Color?> _colorAnimation;

  bool? localIsFavorite;

  @override
  void initState() {
    super.initState();

    // Animation controller'ları başlat
    _favoriteController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Scale animasyonu (favorite olduğunda büyür)
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _favoriteController, curve: Curves.elasticOut));

    // Bounce animasyonu
    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _bounceController, curve: Curves.bounceOut));

    // Renk animasyonu
    _colorAnimation = ColorTween(
      begin: Colors.white.withValues(alpha: 0.7),
      end: Colors.red,
    ).animate(CurvedAnimation(parent: _favoriteController, curve: Curves.easeInOut));

    localIsFavorite = widget.model.isFavorite ?? false;

    if (localIsFavorite == true) {
      _favoriteController.forward();
      _bounceController.forward();
    }
  }

  bool get currentIsFavorite {
    return localIsFavorite ?? widget.model.isFavorite ?? false;
  }

  @override
  Widget build(BuildContext context) {
    var model = widget.model;

    var postOriginalUrl = model.poster ?? "";

    String correctedUrl = postOriginalUrl.replaceFirst(
      "http://ia.media-imdb.com",
      "https://images-na.ssl-images-amazon.com",
    );

    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: CachedNetworkImage(
            imageUrl: correctedUrl,
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              );
            },
            placeholder: (context, url) => ShimmerPlaceholder(),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey.shade200,
              child: Icon(Icons.error_outline, color: Colors.red, size: 40),
            ),
          ),
        ),

        // Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, AppColors.background.withValues(alpha: 0.6)],
            ),
          ),
        ),

        // Content
        SafeArea(
          child: Column(
            children: [
              const Spacer(),

              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: GestureDetector(
                    onTap: toggleFavorite,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 49,
                      height: 71,
                      decoration: BoxDecoration(
                        color: currentIsFavorite
                            ? Colors.black.withValues(alpha: 0.5)
                            : Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(24),
                        border: BoxBorder.all(
                          color: AppColors.grey.withValues(alpha: 0.6),
                        ),
                        boxShadow: currentIsFavorite
                            ? [
                                BoxShadow(
                                  color: Colors.red.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  spreadRadius: 0,
                                ),
                              ]
                            : null,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: Listenable.merge([
                              _scaleAnimation,
                              _bounceAnimation,
                              _colorAnimation,
                            ]),
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _scaleAnimation.value * _bounceAnimation.value,
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 200),
                                  transitionBuilder:
                                      (Widget child, Animation<double> animation) {
                                        return RotationTransition(
                                          turns: animation,
                                          child: ScaleTransition(
                                            scale: animation,
                                            child: child,
                                          ),
                                        );
                                      },
                                  child: Icon(
                                    currentIsFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    key: ValueKey<bool>(currentIsFavorite),
                                    color: _colorAnimation.value,
                                    size: 24,
                                  ),
                                ),
                              );
                            },
                          ),

                          if (currentIsFavorite)
                            AnimatedBuilder(
                              animation: _bounceAnimation,
                              builder: (context, child) {
                                return Opacity(
                                  opacity: _bounceAnimation.value * 0.8,
                                  child: Transform.scale(
                                    scale: _bounceAnimation.value,
                                    child: Icon(
                                      Icons.auto_awesome,
                                      color: Colors.yellow.withValues(alpha: 0.8),
                                      size: 12,
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: BoxBorder.all(color: AppColors.white),
                      ),
                      child: Center(
                        child: Text(
                          (model.title?.isNotEmpty == true)
                              ? model.title![0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Movie Title and Awards
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.title ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ReadMoreText(
                            "${model.awards}",
                            style: TextStyle(
                              color: AppColors.white.withValues(alpha: 0.75),
                              fontSize: 13,
                            ),
                            trimLines: 2,
                            trimMode: TrimMode.Line,
                            moreStyle: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            lessStyle: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            trimExpandedText: lang(LocaleKeys.showLess),
                            trimCollapsedText: lang(LocaleKeys.showMore),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  // MARK: Actions
  void toggleFavorite() async {
    var id = widget.model.id;
    if (id == null) return;

    localIsFavorite = !currentIsFavorite;
    setState(() {});

    if (currentIsFavorite) {
      _favoriteController.forward();
      _bounceController.forward();

      Future.delayed(Duration(milliseconds: 100), () {
        _pulseController.forward().then((_) {
          _pulseController.reverse();
        });
      });
    } else {
      _favoriteController.reverse();
      _bounceController.reverse();
    }

    widget.onFavoriteTab?.call(id);
  }

  @override
  void dispose() {
    _favoriteController.dispose();
    _pulseController.dispose();
    _bounceController.dispose();
    super.dispose();
  }
}
