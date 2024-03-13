import 'package:client/localization/en_us.dart';
import 'package:client/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalization {
  Locale locale;

  AppLocalization(this.locale);

  static final Map<String, Map<String, String>> _localizedValues = {"en": enUs};

  static AppLocalization of() {
    return Localizations.of<AppLocalization>(
        navigatorState.currentContext!, AppLocalization)!;
  }

  static List<String> languages() => _localizedValues.keys.toList();

  String getString(String text) =>
      _localizedValues[locale.languageCode]![text] ?? text;
}

class AppLocalizationDelegate
    implements LocalizationsDelegate<AppLocalization> {
  @override
  bool isSupported(Locale locale) {
    return AppLocalization.languages().contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(AppLocalization(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;

  @override
  Type get type => AppLocalization;
}

extension LocalizationExtension on String {
  String get tr => AppLocalization.of().getString(this);
}
