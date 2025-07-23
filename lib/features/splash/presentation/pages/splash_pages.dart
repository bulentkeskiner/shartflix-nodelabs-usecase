import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/core/app/app_assets_constants.dart';
import 'package:shartflix/core/enum/route_type.dart';
import 'package:shartflix/core/util/context_extension.dart';
import 'package:shartflix/di_helper.dart';
import 'package:shartflix/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:shartflix/features/splash/presentation/bloc/splash_event.dart';
import 'package:shartflix/features/splash/presentation/bloc/splash_state.dart';
import 'package:shartflix/support/app_lang.dart';

class SplashPages extends StatefulWidget {
  const SplashPages({super.key});

  @override
  State<SplashPages> createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    // Gradient animasyon controller'ı
    _gradientController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Logo animasyon controller'ı
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Text animasyon controller'ı
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Logo animasyonları
    _logoScale = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.elasticOut));

    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    // Text animasyonları
    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic));

    // Animasyonları başlat
    _startAnimations();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      sl<SplashBloc>().add(CheckAuthSplashEvent());
    });
  }

  void _startAnimations() async {
    _gradientController.repeat(reverse: true);

    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();

    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashAuthenticated) {
          context.go(RouteType.main.name);
        } else if (state is SplashUnauthenticated) {
          context.go(RouteType.login.name);
        } else if (state is SplashError) {
          context.showDefaultSnackbar(state.message);
          context.go(RouteType.login.name);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: AnimatedBuilder(
            animation: _gradientController,
            builder: (context, child) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.0,
                      _gradientController.value * 0.3 + 0.2,
                      _gradientController.value * 0.5 + 0.4,
                      1.0,
                    ],
                    colors: [
                      Color.lerp(
                        const Color(0xFF6A1B6E),
                        const Color(0xFF8E2D5F),
                        _gradientController.value,
                      )!,
                      Color.lerp(
                        const Color(0xFF4A1548),
                        const Color(0xFF6A1B6E),
                        _gradientController.value * 0.8,
                      )!,
                      Color.lerp(
                        const Color(0xFF2D1B2E),
                        const Color(0xFF4A1548),
                        _gradientController.value * 0.6,
                      )!,
                      Color.lerp(
                        const Color(0xFF1A0D1F),
                        const Color(0xFF2D1B2E),
                        _gradientController.value * 0.4,
                      )!,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),

                      AnimatedBuilder(
                        animation: _logoController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _logoScale.value,
                            child: Opacity(
                              opacity: _logoOpacity.value,
                              child: Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      const Color(0xFFE91E63),
                                      const Color(0xFF8E2D5F),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFFE91E63,
                                      ).withValues(alpha: 0.3),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  AssetsConstants.logoTransparent,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 40),

                      AnimatedBuilder(
                        animation: _textController,
                        builder: (context, child) {
                          return SlideTransition(
                            position: _textSlide,
                            child: FadeTransition(
                              opacity: _textOpacity,
                              child: Column(
                                children: [
                                  Text(
                                    lang(LocaleKeys.appName),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 3,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    lang(LocaleKeys.splashSubtitle),
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.7),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const Spacer(flex: 2),

                      // Loading göstergesi
                      AnimatedBuilder(
                        animation: _gradientController,
                        builder: (context, child) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 50),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.lerp(
                                        const Color(0xFFE91E63),
                                        Colors.white,
                                        _gradientController.value * 0.3,
                                      )!,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  lang(LocaleKeys.loading),
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }
}
