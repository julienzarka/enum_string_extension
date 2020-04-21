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
