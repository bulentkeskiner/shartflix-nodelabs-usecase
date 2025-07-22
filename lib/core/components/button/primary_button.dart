import 'package:flutter/material.dart';
import 'package:shartflix/core/theme/constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final WidgetStatePropertyAll<Color>? backgroundColor;
  final WidgetStatePropertyAll<EdgeInsets>? padding;
  final Color? textColor;
  final Color? borderColor;
  final double? fontSize;

  const PrimaryButton({
    super.key,
    required this.title,
    this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.padding,
    this.borderColor,
    this.fontSize,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 53,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(color: textColor ?? AppColors.white, fontSize: fontSize),
        ),
      ),
    );
  }
}
