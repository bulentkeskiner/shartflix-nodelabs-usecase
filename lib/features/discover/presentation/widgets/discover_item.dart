import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

class _DiscoverItemState extends State<DiscoverItem> {
  @override
  Widget build(BuildContext context) {
    var model = widget.model;

    var postOriginalUrl = model.poster ?? "";

    String correctedUrl = postOriginalUrl.replaceFirst(
      "http://ia.media-imdb.com",
      "https://images-na.ssl-images-amazon.com",
    );

    var isFavorite = model.isFavorite ?? false;

    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(correctedUrl),
                fit: BoxFit.fill,
              ),
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
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(24),
                        border: BoxBorder.all(
                          color: AppColors.grey.withValues(alpha: 0.6),
                        ),
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return ScaleTransition(scale: animation, child: child);
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            key: ValueKey<bool>(isFavorite),
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Movie Info
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
                          if ((model.awards ?? "").isNotEmpty)
                            ReadMoreText(
                              "${model.awards} ${model.awards!}",
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
  toggleFavorite() {
    var id = widget.model.id;
    if (id != null) widget.onFavoriteTab?.call(id);
  }
}
