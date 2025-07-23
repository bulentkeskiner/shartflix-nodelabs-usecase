import 'package:flutter/material.dart';

abstract class LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  final Locale locale;
  final String flag;

  ChangeLanguageEvent(this.locale, this.flag);
}
