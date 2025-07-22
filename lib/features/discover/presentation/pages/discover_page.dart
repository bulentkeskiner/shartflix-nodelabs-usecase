import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/di_helper.dart';
import 'package:shartflix/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shartflix/features/discover/presentation/bloc/discover_event.dart';
import 'package:shartflix/features/discover/presentation/bloc/discover_state.dart';
import 'package:shartflix/features/discover/presentation/widgets/discover_item.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_event.dart';
import 'package:shartflix/models/movie_model.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final PageController pageController = PageController();

  List<MovieModel> movies = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      sl<DiscoverBloc>().add(DiscoverInitialLoad());
    });

    pageController.addListener(() {
      final currentPage = pageController.page?.round() ?? 0;

      if (currentPage == movies.length - 1) {
        print("onLoad: 2");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscoverBloc, DiscoverState>(
      listener: (context, state) {
        if (state is DiscoverLoadedState) {
          movies = state.items;
        }

        /*if (state is DiscoverLoadingFavoriteState) {
          context.showLoader();
        } else {
          context.hideLoader();
        }*/

        if (state is DiscoverCompleteFavoriteState) {
          movies = state.items;

          sl<ProfileBloc>().add(MyFavoritesLoadedEvent());
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Builder(
            builder: (context) {
              return PageView.builder(
                controller: pageController,
                scrollDirection: Axis.vertical,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  var model = movies[index];
                  return DiscoverItem(
                    model: model,
                    onFavoriteTab: (id) => toggleFavoriteTab(id),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  // MARK: Actions
  void toggleFavoriteTab(String id) {
    sl<DiscoverBloc>().add(DiscoverToggleFavorite(id));
  }

  @override
  void dispose() {
    super.dispose();
    pageController.removeListener(() {});
  }
}
