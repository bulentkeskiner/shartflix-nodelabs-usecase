import 'package:flutter/material.dart';
import 'package:shartflix/core/app/app_assets_constants.dart';
import 'package:shartflix/core/components/app_ink_well.dart';
import 'package:shartflix/core/theme/constants/app_colors.dart';
import 'package:shartflix/di_helper.dart';
import 'package:shartflix/features/limited_offer/presentation/pages/limited_offer_page.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_event.dart';
import 'package:shartflix/features/profile/presentation/widgets/my_favorite_movie_view.dart';
import 'package:shartflix/features/profile/presentation/widgets/profile_view.dart';
import 'package:shartflix/support/app_lang.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      sl<ProfileBloc>().add(ProfileLoadedEvent());
      sl<ProfileBloc>().add(MyFavoritesLoadedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            sl<ProfileBloc>().add(ProfileLoadedEvent());
            sl<ProfileBloc>().add(MyFavoritesLoadedEvent());
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lang(LocaleKeys.screenTitle),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppInkWell(
                      onTap: () => onTapLimitedOffer(),
                      child: Container(
                        height: 35,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AssetsConstants.gem,
                              color: Colors.white,
                              width: 18,
                              height: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              lang(LocaleKeys.limitedOffer),
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Info
              ProfileView(),

              const SizedBox(height: 32),

              // Movies Section
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
    );
  }

  // MARK: Actions
  onTapLimitedOffer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      builder: (context) {
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.8,
          child: LimitedOfferPage(),
        );
      },
    );
  }
}
