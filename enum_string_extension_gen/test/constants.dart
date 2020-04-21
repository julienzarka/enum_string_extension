const String pkgName = "enum_string_extension_gen";

const String annotationsBase = r'''
/// Provides annotation class to use with
/// [enum_string_extension_gen](https://pub.dev/packages/enum_string_extension_gen).
library enum_string_extension;

/// Annotation used to indicate that the `EnumString` extension should be generated.
const enumString = EnumString();

class EnumString {
  /// Creates a new [EnumString] instance.
  const EnumString();
}
''';

const String correctInput = r'''
import 'dart:ui' show Locale;

import 'package:enum_string_extension/enum_string_extension.dart';
import 'package:flutter/cupertino.dart' show Localizations, BuildContext;
import 'package:meta/meta.dart' show immutable;

part 'basic_class.g.dart';

// The localizations delagate must be called AppLocalizations and implement each field of the enum
class AppLocalizations {
  AppLocalizations(this.locale) : labels = languages[locale];

  final Locale locale;
  static final Map<Locale, AppLocalizationsLabels> languages = <Locale, AppLocalizationsLabels>{
    const Locale.fromSubtags(languageCode: 'en', countryCode: 'US'): const AppLocalizationsLabels(
      value1: 'Value 1 in english',
      value2: 'Value 2 in english',
      value3: 'Value 3 in english',
    )
  };

  final AppLocalizationsLabels labels;

  static AppLocalizationsLabels of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)?.labels;
}

class AppLocalizationsLabels {
  const AppLocalizationsLabels({
    this.value1,
    this.value2,
    this.value3,
  });

  final String value1;
  final String value2;
  final String value3;
}

enum TestEnum3 {
  value1,
  value3,
}

enum TestEnum2 {
  value1,
  value2,
  value3,
}

enum TestEnum {
  value1,
  value2,
}

@immutable
@enumString
class BasicClass {
  const BasicClass({
    this.test,
    this.test2,
    this.test3,
  });

  final TestEnum test;
  final TestEnum2 test2;
  final List<TestEnum3> test3;
}
''';

const String correctResult = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_class.dart';

// **************************************************************************
// EnumStringGenerator
// **************************************************************************

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_type, always_specify_types

extension TestEnumStringExtension on TestEnum {
  String text(BuildContext context) {
    switch (this) {
      case TestEnum.value1:
        return AppLocalizations.of(context).value1;
      case TestEnum.value2:
        return AppLocalizations.of(context).value2;

      default:
        break;
    }
    return AppLocalizations.of(context).value1;
  }
}

extension TestEnum2StringExtension on TestEnum2 {
  String text(BuildContext context) {
    switch (this) {
      case TestEnum2.value1:
        return AppLocalizations.of(context).value1;
      case TestEnum2.value2:
        return AppLocalizations.of(context).value2;
      case TestEnum2.value3:
        return AppLocalizations.of(context).value3;

      default:
        break;
    }
    return AppLocalizations.of(context).value1;
  }
}

extension TestEnum3StringExtension on TestEnum3 {
  String text(BuildContext context) {
    switch (this) {
      case TestEnum3.value1:
        return AppLocalizations.of(context).value1;
      case TestEnum3.value3:
        return AppLocalizations.of(context).value3;

      default:
        break;
    }
    return AppLocalizations.of(context).value1;
  }
}

''';
