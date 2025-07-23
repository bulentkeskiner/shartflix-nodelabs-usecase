import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/core/components/app_ink_well.dart';
import 'package:shartflix/core/enum/route_type.dart';
import 'package:shartflix/di_helper.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_event.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_state.dart';
import 'package:shartflix/models/movie_model.dart';
import 'package:shartflix/support/app_lang.dart';

class MyFavoriteMovieView extends StatefulWidget {
  const MyFavoriteMovieView({super.key});

  @override
  State<MyFavoriteMovieView> createState() => _MyFavoriteMovieViewState();
}

class _MyFavoriteMovieViewState extends State<MyFavoriteMovieView> {
  List<MovieModel> favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      sl<ProfileBloc>().add(MyFavoritesLoadedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return Container();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lang(LocaleKeys.likedMovies),
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: favoriteMovies.length,
                itemBuilder: (context, index) {
                  final movie = favoriteMovies[index];

                  var postOriginalUrl = movie.poster ?? "";

                  String correctedUrl = postOriginalUrl.replaceFirst(
                    "http://ia.media-imdb.com",
                    "https://images-na.ssl-images-amazon.com",
                  );

                  return AppInkWell(
                    onTap: () => onTapMovieDetail(movie),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(correctedUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.title ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          movie.genre ?? "",
                          style: TextStyle(color: Colors.grey[400], fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      listener: (context, state) {
        if (state is MyFavoritesCompleteState) {
          favoriteMovies = state.favoriteMovies;
        }
      },
    );
  }

  onTapMovieDetail(MovieModel model) {
    context.pushNamed(RouteType.movieDetail.name, extra: model);
  }
}
