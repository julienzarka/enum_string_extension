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

class EnumKey {
  final String prefix;
  final bool exclude;
  const EnumKey({String prefix, bool exclude})
      : prefix = prefix ?? '',
        exclude = exclude ?? false;
}
''';

const String correctInput = r'''
import 'dart:ui' show Locale;

import 'package:enum_string_extension/enum_string_extension.dart';
import 'package:flutter/cupertino.dart' show Localizations, BuildContext;
import 'package:json_annotation/json_annotation.dart';
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
      testValue1: 'TestValue 1 in english',
      testValue2: 'TestValue 2 in english',
      test2Value1: 'Test2Value 1 in english',
      test2Value2: 'Test2Value 2 in english',
      myTestValue1: 'TestValue 1 in english',
      myTestValue2: 'TestValue 2 in english',
      mySecondTestValue1: 'TestValue 1 in english',
      mySecondTestValue2: 'TestValue 2 in english',
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
    this.testValue1,
    this.testValue2,
    this.test2Value1,
    this.test2Value2,
    this.myTestValue1,
    this.myTestValue2,
    this.mySecondTestValue1,
    this.mySecondTestValue2,
    this.variantValue5,
    this.variantValue6,
  });

  final String value1;
  final String value2;
  final String value3;
  final String testValue1;
  final String testValue2;
  final String test2Value1;
  final String test2Value2;
  final String myTestValue1;
  final String myTestValue2;
  final String mySecondTestValue1;
  final String mySecondTestValue2;
  final String variantValue5;
  final String variantValue6;
}

enum TestEnum4 {
  value1,
  value3,
}

enum TestEnum3 {
  value5,
  value6,
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
    this.test4,
    this.test5,
    this.test6,
    this.test7,
    this.test8,
    this.test9,
    this.test10,
    this.test11,
  });

  // Should generate text() for TestEnum
  final TestEnum test;
  // Should generate text() TestEnum2
  final TestEnum2 test2;
  // Should generate variantText() for TestEnum3 - not the text()
  @EnumKey(prefix: 'variant')
  final List<TestEnum3> test3;

  // Should generate myTestText() for TestEnum - ignore other annotations
  @JsonKey(ignore: true)
  @EnumKey(prefix: 'myTest')
  @EnumKey(prefix: 'mySecondTest')
  final TestEnum test4;
// Should generate testText() for TestEnum
  @EnumKey(prefix: 'test2')
  final TestEnum test5;

  // Should not generate code

  // Duplicate prefix
  final TestEnum test6;
  // Should not generate duplicate text() for TestEnum
  @EnumKey(prefix: 'test')
  final TestEnum test7;
  @EnumKey(prefix: 'Test')
  final TestEnum test8;
  // Not enum fields
  final String test9;
  final List<String> test10;
  // Excluded enum
  @EnumKey(exclude: true)
  final TestEnum4 test11;
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

extension TestEnumMyTestStringExtension on TestEnum {
  String myTestText(BuildContext context) {
    switch (this) {
      case TestEnum.value1:
        return AppLocalizations.of(context).myTestValue1;
      case TestEnum.value2:
        return AppLocalizations.of(context).myTestValue2;
      default:
        break;
    }
    return AppLocalizations.of(context).myTestValue1;
  }
}

extension TestEnumMySecondTestStringExtension on TestEnum {
  String mySecondTestText(BuildContext context) {
    switch (this) {
      case TestEnum.value1:
        return AppLocalizations.of(context).mySecondTestValue1;
      case TestEnum.value2:
        return AppLocalizations.of(context).mySecondTestValue2;
      default:
        break;
    }
    return AppLocalizations.of(context).mySecondTestValue1;
  }
}

extension TestEnumTest2StringExtension on TestEnum {
  String test2Text(BuildContext context) {
    switch (this) {
      case TestEnum.value1:
        return AppLocalizations.of(context).test2Value1;
      case TestEnum.value2:
        return AppLocalizations.of(context).test2Value2;
      default:
        break;
    }
    return AppLocalizations.of(context).test2Value1;
  }
}

extension TestEnumTestStringExtension on TestEnum {
  String testText(BuildContext context) {
    switch (this) {
      case TestEnum.value1:
        return AppLocalizations.of(context).testValue1;
      case TestEnum.value2:
        return AppLocalizations.of(context).testValue2;
      default:
        break;
    }
    return AppLocalizations.of(context).testValue1;
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

extension TestEnum3VariantStringExtension on TestEnum3 {
  String variantText(BuildContext context) {
    switch (this) {
      case TestEnum3.value5:
        return AppLocalizations.of(context).variantValue5;
      case TestEnum3.value6:
        return AppLocalizations.of(context).variantValue6;
      default:
        break;
    }
    return AppLocalizations.of(context).variantValue5;
  }
}

''';
