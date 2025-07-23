import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/core/enum/route_type.dart';
import 'package:shartflix/features/auth/presentation/pages/login_page.dart';
import 'package:shartflix/features/auth/presentation/pages/register_page.dart';
import 'package:shartflix/features/main_navigation/presentation/pages/main_navigation_page.dart';
import 'package:shartflix/features/profile/presentation/pages/moview_detail_page.dart';
import 'package:shartflix/features/profile/presentation/pages/photo_upload_page.dart';
import 'package:shartflix/features/splash/presentation/pages/splash_pages.dart';
import 'package:shartflix/models/movie_model.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static AppRouter? _instance;
  static AppRouter get instance => _instance ??= AppRouter._init();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "navigateKey");

  AppRouter._init();

  final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteType.splash.name,
    routes: [
      GoRoute(
        path: RouteType.splash.name,
        builder: (context, state) => const SplashPages(),
      ),
      GoRoute(
        path: RouteType.register.name,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(path: RouteType.login.name, builder: (context, state) => const LoginPage()),
      GoRoute(
        path: RouteType.photoUpload.name,
        builder: (context, state) => const PhotoUploadPage(),
      ),
      GoRoute(
        path: RouteType.main.name,
        builder: (context, state) => const MainNavigationPage(),
      ),
      GoRoute(
        path: RouteType.movieDetail.name,
        builder: (context, state) {
          var extra = state.extra as MovieModel?;
          return MovieDetailPage(movie: extra);
        },
      ),
    ],
  );
}
