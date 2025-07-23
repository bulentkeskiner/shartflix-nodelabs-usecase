import 'package:flutter/material.dart';
import 'package:shartflix/core/app/app_assets_constants.dart';
import 'package:shartflix/core/components/button/primary_button.dart';
import 'package:shartflix/core/theme/constants/app_colors.dart';
import 'package:shartflix/support/app_lang.dart';

class LimitedOfferPage extends StatefulWidget {
  const LimitedOfferPage({super.key});

  @override
  State<LimitedOfferPage> createState() => _LimitedOfferPageState();
}

class _LimitedOfferPageState extends State<LimitedOfferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.0,
            colors: [AppColors.primary.withValues(alpha: 0.4), AppColors.black],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  lang(LocaleKeys.limitedOffer),
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  lang(LocaleKeys.limited_offer_description),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        lang(LocaleKeys.your_bonuses),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildBonusItem(
                            path: AssetsConstants.bonusImage1,
                            title: lang(LocaleKeys.bonus_premium),
                            color: const Color(0xFFE91E63),
                          ),
                          _buildBonusItem(
                            path: AssetsConstants.bonusImage2,
                            title: lang(LocaleKeys.bonus_more_matches),
                            color: const Color(0xFFE91E63),
                          ),
                          _buildBonusItem(
                            path: AssetsConstants.bonusImage3,
                            title: lang(LocaleKeys.bonus_boost),
                            color: const Color(0xFFE91E63),
                          ),
                          _buildBonusItem(
                            path: AssetsConstants.bonusImage4,
                            title: lang(LocaleKeys.bonus_more_likes),
                            color: const Color(0xFFE91E63),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  lang(LocaleKeys.unlock_with_package),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: _buildJetonItem(
                        bonus: '+10%',
                        oldPrice: '200',
                        newPrice: '330',
                        jeton: lang(LocaleKeys.jeton),
                        price: '₺99,99',
                        bottomTitle: lang(LocaleKeys.per_week),
                        bonusColor: AppColors.redDark,
                        backgroundColor: AppColors.red,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildJetonItem(
                        bonus: '+70%',
                        oldPrice: '2.000',
                        newPrice: '3.375',
                        jeton: lang(LocaleKeys.jeton),
                        price: '₺799,99',
                        bottomTitle: lang(LocaleKeys.per_week),
                        bonusColor: AppColors.purple,
                        backgroundColor: AppColors.red,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildJetonItem(
                        bonus: '+35%',
                        oldPrice: '1.000',
                        newPrice: '1.350',
                        jeton: lang(LocaleKeys.jeton),
                        price: '₺399,99',
                        bottomTitle: lang(LocaleKeys.per_week),
                        bonusColor: AppColors.redDark,
                        backgroundColor: AppColors.red,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Satın al butonu
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: PrimaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: lang(LocaleKeys.view_all_tokens),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBonusItem({
    required String path,
    required String title,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white.withValues(alpha: 0.2), width: 3),
            ),
            child: Padding(padding: const EdgeInsets.all(8.0), child: Image.asset(path)),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 32,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJetonItem({
    required String bonus,
    required String oldPrice,
    required String newPrice,
    required String jeton,
    required String price,
    required String bottomTitle,
    required Color bonusColor,
    required Color backgroundColor,
  }) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.2),
                  width: 2.6,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [bonusColor.withValues(alpha: 0.8), backgroundColor],
                ),
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          oldPrice,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: AppColors.white,
                          ),
                        ),

                        Text(
                          newPrice,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          jeton,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(
                    color: AppColors.white.withValues(alpha: 0.2),
                    thickness: 1.2,
                    endIndent: 10,
                    indent: 10,
                  ),

                  Flexible(
                    flex: 3,
                    child: Column(
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),

                        // Alt başlık
                        Text(
                          bottomTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bonus etiketi
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 61,
                height: 25,
                decoration: BoxDecoration(
                  color: bonusColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.2),
                    width: 2.6,
                  ),
                ),
                child: Center(
                  child: Text(
                    bonus,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
