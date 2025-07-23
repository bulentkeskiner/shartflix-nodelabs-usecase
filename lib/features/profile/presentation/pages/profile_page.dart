import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/core/enum/route_type.dart';
import 'package:shartflix/core/theme/constants/app_colors.dart';
import 'package:shartflix/di_helper.dart';
import 'package:shartflix/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shartflix/features/auth/presentation/bloc/auth_event.dart';
import 'package:shartflix/features/language/presentation/bloc/lang_bloc.dart';
import 'package:shartflix/features/language/presentation/bloc/lang_event.dart';
import 'package:shartflix/features/limited_offer/presentation/pages/limited_offer_page.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_event.dart';
import 'package:shartflix/features/profile/presentation/widgets/my_favorite_movie_view.dart';
import 'package:shartflix/features/profile/presentation/widgets/profile_view.dart';
import 'package:shartflix/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:shartflix/features/theme/presentation/bloc/theme_event.dart';
import 'package:shartflix/support/app_lang.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  late AnimationController _themeAnimationController;
  late AnimationController _exitAnimationController;
  late Animation<double> _themeRotationAnimation;
  late Animation<double> _exitScaleAnimation;

  @override
  void initState() {
    super.initState();

    _themeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _exitAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _themeRotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _themeAnimationController, curve: Curves.elasticOut),
    );

    _exitScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(parent: _exitAnimationController, curve: Curves.easeInOut));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      sl<ProfileBloc>().add(ProfileLoadedEvent());
      sl<ProfileBloc>().add(MyFavoritesLoadedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    context.watch<LanguageBloc>();

    final isDarkMode = themeState.isDarkMode;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: isDarkMode
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1a1a2e), Color(0xFF16213e), Colors.black],
              )
            : const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFf8f9fa), Color(0xFFe9ecef), Colors.white],
              ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              sl<ProfileBloc>().add(ProfileLoadedEvent());
              sl<ProfileBloc>().add(MyFavoritesLoadedEvent());
            },
            child: Column(
              children: [
                _buildEnhancedHeader(isDarkMode),

                ProfileView(),

                const SizedBox(height: 32),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: MyFavoriteMovieView(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedHeader(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lang(LocaleKeys.screenTitle),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  _buildAnimatedButton(
                    onTap: _toggleTheme,
                    child: RotationTransition(
                      turns: _themeRotationAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.2),
                          // : Colors.indigo.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.amber, width: 1),
                        ),
                        child: Icon(
                          isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          color: isDarkMode ? Colors.amber : Colors.indigo,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  _buildAnimatedButton(
                    onTap: _showLanguageSelector,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.language, color: Colors.blue, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            context.locale.languageCode.toUpperCase(),
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  _buildAnimatedButton(
                    onTap: () => onTapLimitedOffer(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.primary.withValues(alpha: 0.6)
                            : AppColors.primary.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary, width: 1),
                      ),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 1500),
                        builder: (context, value, child) {
                          return Transform.rotate(
                            angle: value * 2 * 3.14159,
                            child: Icon(Icons.stars, color: Colors.white, size: 16),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  ScaleTransition(
                    scale: _exitScaleAnimation,
                    child: _buildAnimatedButton(
                      onTap: _showExitDialog,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red, width: 1),
                        ),
                        child: const Icon(Icons.exit_to_app, color: Colors.red, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          /*AppInkWell(
            onTap: () => onTapLimitedOffer(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1500),
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: value * 2 * 3.14159,
                        child: Image.asset(
                          AssetsConstants.gem,
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    lang(LocaleKeys.limitedOffer),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.stars, color: Colors.white, size: 16),
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget _buildAnimatedButton({required VoidCallback onTap, required Widget child}) {
    return SizedBox(
      height: 36,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.0, end: 1.0),
        duration: const Duration(milliseconds: 100),
        builder: (context, scale, _) {
          return Transform.scale(
            scale: scale,
            child: GestureDetector(
              onTapDown: (_) {
                HapticFeedback.lightImpact();
              },
              onTap: onTap,
              child: child,
            ),
          );
        },
      ),
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1a1a2e),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      lang(LocaleKeys.selectLanguage),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildLanguageOption('tr', 'Türkçe', 'TR'),
                    _buildLanguageOption('en', 'English', 'EN'),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String code, String name, String flag) {
    var selectedLanguage = context.locale;
    bool isSelected = selectedLanguage.languageCode == code;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          var newLocale = Locale(code, code.toUpperCase());
          context.setLocale(newLocale);
          sl<LanguageBloc>().add(ChangeLanguageEvent(newLocale, flag));
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.withValues(alpha: 0.2) : Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
          ),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
              Text(
                code,
                style: TextStyle(
                  color: isSelected ? Colors.blue : Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 8),
                const Icon(Icons.check, color: Colors.blue, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // MARK: Actions
  void _toggleTheme() {
    // DEVNOTES: Zaman kısıtlamasından dolayı Light thema için detaylı düzenleme yapılmadı.
    // Fakat tema değiştirme aksiyonu eklendi.
    sl<ThemeBloc>().add(ToggleThemeEvent());
    _themeAnimationController.forward().then((_) {
      _themeAnimationController.reset();
    });
  }

  void _showExitDialog() {
    _exitAnimationController.forward().then((_) {
      _exitAnimationController.reverse();
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1a1a2e),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.exit_to_app, color: Colors.red),
              const SizedBox(width: 8),
              Text(
                lang(LocaleKeys.logout),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          content: Text(
            lang(LocaleKeys.logoutConfirmation),
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                lang(LocaleKeys.cancel),
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Çıkış işlemi
                _performExit();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(lang(LocaleKeys.logout)),
            ),
          ],
        );
      },
    );
  }

  void _performExit() {
    sl<AuthBloc>().add(LogoutEvent());
    context.go(RouteType.splash.name);
  }

  onTapLimitedOffer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: const Color(0xFF1a1a2e),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: LimitedOfferPage(),
        );
      },
    );
  }

  @override
  void dispose() {
    _themeAnimationController.dispose();
    _exitAnimationController.dispose();
    super.dispose();
  }
}
