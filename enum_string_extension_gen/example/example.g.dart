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
