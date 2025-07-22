import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shartflix/core/theme/constants/app_colors.dart';
import 'package:shartflix/core/theme/theme_data/app_style.dart';

extension ContextLoadExtension on BuildContext {
  Future<T> loadingExecute<T>(Future<T> Function() onExecute, {Widget? widget}) async {
    loaderOverlay.show();
    var success = await onExecute();
    loaderOverlay.hide();
    return success;
  }

  bool get isLoading => loaderOverlay.visible;

  void hideLoader() {
    if (isLoading) {
      loaderOverlay.hide();
    }
  }

  void showLoader() {
    if (!isLoading) {
      loaderOverlay.show();
    }
  }

  showDefaultSnackbar(String title, {int duration = 2}) {
    var snackbar = SnackBar(
      content: Text(title, style: AppStyles.toastStyle),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(8),
      backgroundColor: AppColors.background,
    );
    ScaffoldMessenger.of(this).showSnackBar(snackbar);
  }
}
