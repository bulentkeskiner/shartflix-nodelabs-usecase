import 'package:flutter/material.dart';
import 'package:shartflix/core/theme/app_theme.dart';
import 'package:shartflix/core/theme/theme_data/dark_theme_data.dart';

class DarkTheme extends IAppTheme {
  DarkTheme();

  @override
  ThemeData get theme => DarkThemeData.instance.data;
}
