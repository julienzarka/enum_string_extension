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
