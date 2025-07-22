import 'package:flutter/material.dart';
import 'package:shartflix/core/theme/app_theme.dart';
import 'package:shartflix/core/theme/theme_data/light_theme_data.dart';

class AppThemeLight extends IAppTheme {
  AppThemeLight.init();

  @override
  ThemeData get theme => LightThemeData.instance.data;
}
