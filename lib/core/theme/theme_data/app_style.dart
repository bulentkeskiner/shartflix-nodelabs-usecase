import 'package:flutter/material.dart';
import 'package:shartflix/core/theme/constants/app_colors.dart';

class AppStyles {
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle toastStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const TextStyle body = TextStyle(fontSize: 16, color: AppColors.white);

  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static const TextStyle hintText = TextStyle(fontSize: 14, color: AppColors.grey);

  static const TextStyle alreadyText = TextStyle(
    fontSize: 12,
    color: AppColors.grey,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle smallGrey = TextStyle(fontSize: 12, color: AppColors.grey);
}
