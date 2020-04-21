import 'dart:ui' show Locale;

import 'package:enum_string_extension/enum_string_extension.dart';
import 'package:flutter/cupertino.dart' show Localizations, BuildContext;
import 'package:meta/meta.dart' show immutable;

/// Make sure that `part` is specified, even before launching the builder
part 'example.g.dart';

// The localizations delagate must be called AppLocalizations and implement each field of the enum
class AppLocalizations {
  AppLocalizations(this.locale) : labels = languages[locale];

  final Locale locale;
  static final Map<Locale, AppLocalizationsLabels> languages = <Locale, AppLocalizationsLabels>{
    const Locale.fromSubtags(languageCode: 'en', countryCode: 'US'): const AppLocalizationsLabels(
      value1: 'Value 1 in english',
      value2: 'Value 2 in english',
    )
  };

  final AppLocalizationsLabels labels;

  static AppLocalizationsLabels of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)?.labels;
}

enum TestEnum {
  value1,
  value2,
}

@immutable
// Annotation cannot be on the enum directly, one of the class containing the enum and with the enum declaration in
// the same file must be annotated with the `@enumString` annotation.
@enumString
class SimpleObject {
  final TestEnum value;

  const SimpleObject({this.value});
}
