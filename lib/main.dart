import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shartflix/core/app/app_init.dart';
import 'package:shartflix/core/components/loading/default_loading.dart';
import 'package:shartflix/core/routing/app_router.dart';
import 'package:shartflix/core/theme/theme_data/dark_theme_data.dart';
import 'package:shartflix/core/theme/theme_data/light_theme_data.dart';
import 'package:shartflix/di_helper.dart';
import 'package:shartflix/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shartflix/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:shartflix/features/language/presentation/bloc/lang_bloc.dart';
import 'package:shartflix/features/language/presentation/bloc/lang_state.dart';
import 'package:shartflix/features/main_navigation/presentation/cubit/main_nav_cubit.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shartflix/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:shartflix/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:shartflix/features/theme/presentation/bloc/theme_state.dart';

Future<void> main() async {
  await ApplicationInitialize().make();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('tr', 'TR'), Locale('en', 'EN')],
      path: 'assets/lang',
      fallbackLocale: const Locale('tr-TR'),
      startLocale: const Locale('tr-TR'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      disableBackButton: true,
      overlayColor: Colors.grey.withValues(alpha: 0.1),
      overlayWidgetBuilder: (progress) {
        return const DefaultLoading();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<AuthBloc>()),
          BlocProvider(create: (_) => sl<SplashBloc>()),
          BlocProvider(create: (_) => sl<DiscoverBloc>()),
          BlocProvider(create: (_) => sl<MainNavCubit>()),
          BlocProvider(create: (_) => sl<ProfileBloc>()),
          BlocProvider(create: (_) => sl<ThemeBloc>()),
          BlocProvider(create: (_) => sl<LanguageBloc>()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, langState) {
                return MaterialApp.router(
                  title: 'Shartflix App',
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  ),
                  routerDelegate: AppRouter.instance.router.routerDelegate,
                  routeInformationParser:
                      AppRouter.instance.router.routeInformationParser,
                  routeInformationProvider:
                      AppRouter.instance.router.routeInformationProvider,
                  debugShowCheckedModeBanner: true,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: langState.locale,
                  themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                  darkTheme: state.isDarkMode
                      ? DarkThemeData.instance.data
                      : LightThemeData.instance.data,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
