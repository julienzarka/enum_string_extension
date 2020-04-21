import 'package:analyzer/dart/element/element.dart' show ClassElement, Element, FieldElement;
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart' show BuildStep;
import 'package:enum_string_extension/enum_string_extension.dart';
import 'package:source_gen/source_gen.dart' show GeneratorForAnnotation, ConstantReader;

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String unCapitalize() {
    return "${this[0].toLowerCase()}${this.substring(1)}";
  }
}

/// A `Generator` for `package:build_runner`
class EnumStringGenerator extends GeneratorForAnnotation<EnumString> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) throw "$element is not a ClassElement";
    final List<DartType> sortedEnums = _sortedEnums(element as ClassElement);

    //Since we do not support generic types, we must suppress these checks
    final ignored_analyzer_rules = '''
    // ignore_for_file: argument_type_not_assignable, implicit_dynamic_type, always_specify_types
    ''';

    return '''
    $ignored_analyzer_rules
    
    ${_generateEnumString(sortedEnums)}
    ''';
  }

  final _enumMapExpando = Expando<Map<FieldElement, dynamic>>();

  /// If [targetType] is an enum, returns a [Map] of the [FieldElement] instances
  /// associated with the enum values mapped to the [String] values that represent
  /// the serialized output.
  ///
  /// By default, the [String] value is just the name of the enum value.
  /// If the enum value is annotated with [JsonKey], then the `name` property is
  /// used if it's set and not `null`.
  ///
  /// Handle enum inside lists, List<enum>.
  ///
  /// If [targetType] is not an enum, `null` is returned.
  Map<FieldElement, dynamic> enumFieldsMap(DartType targetType) {
    MapEntry<FieldElement, dynamic> _generateEntry(FieldElement fe) {
      dynamic fieldValue = fe.name;
      final entry = MapEntry(fe, fieldValue);
      return entry;
    }

    if (targetType is InterfaceType && targetType.element.isEnum) {
      return _enumMapExpando[targetType] ??= Map<FieldElement, dynamic>.fromEntries(
          targetType.element.fields.where((p) => !p.isSynthetic).map(_generateEntry));
    }
    return null;
  }

  String _generateEnumString(List<DartType> sortedEnums) {
    String result = '';
    for (DartType t in sortedEnums) {
      final enumMap = enumFieldsMap(t);
      if (enumMap == null) continue;
      result += '''
      extension ${t.getDisplayString()}StringExtension on ${t.getDisplayString()} {
        String text(BuildContext context) {
          switch(this) {
            ${enumMap.entries.map((e) => 'case ${t.element.name}.${e.key.name}: return AppLocalizations.of(context).${e.key.name};\n').join()}
            default:
              break;
          }
          return AppLocalizations.of(context).${enumMap.keys.first.name};
        }
      }
      
      ''';
    }
    return result;
  }

  List<DartType> _sortedEnums(ClassElement element) {
    assert(element is ClassElement);
    List<DartType> t = element.fields.map<DartType>((FieldElement e) => e.type).toList();
    return t
        .map<DartType>((DartType e) => e.isDartCoreList ? (e as ParameterizedType).typeArguments.first : e)
        .toList();
  }
}
