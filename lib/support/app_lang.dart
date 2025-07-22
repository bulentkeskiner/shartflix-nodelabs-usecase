import 'package:easy_localization/easy_localization.dart';

export 'locale_keys.g.dart';

class AppLang {
  AppLang._();
  static String tr(String path) => path.tr();
}

String lang(String path) => AppLang.tr(path);
