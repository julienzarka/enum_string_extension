import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart' show ClassElement, Element, ElementAnnotation, FieldElement;
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart' show BuildStep;
import 'package:enum_string_extension/enum_string_extension.dart';
import 'package:source_gen/source_gen.dart' show GeneratorForAnnotation, ConstantReader;

extension StringExtension on String {
  String capitalize() => this != null && this.isNotEmpty ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String unCapitalize() => this != null && this.isNotEmpty ? '${this[0].toLowerCase()}${this.substring(1)}' : '';
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
    final List<_LocalFields> sortedEnums = _sortedEnums(element as ClassElement);

    //Since we do not support generic types, we must suppress these checks
    final ignored_analyzer_rules = '''
    // ignore_for_file: argument_type_not_assignable, implicit_dynamic_type, always_specify_types
    ''';

    return '''
    $ignored_analyzer_rules
    
    ${_generateEnumString(sortedEnums)}
    ''';
  }

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

  String _generateEnumString(List<_LocalFields> sortedEnums) {
    String result = '';
    for (_LocalFields t in sortedEnums) {
      if (t.enumMap == null) continue;
      if (t.enumKey.exclude == true) continue;
      result += '''
      extension ${t.type.getDisplayString()}${t.enumKey.prefix.capitalize()}StringExtension on ${t.type.getDisplayString()} {
        String ${t.enumKey.prefix.isEmpty ? 'text' : '${t.enumKey.prefix.unCapitalize()}Text'}(BuildContext context) {
          switch(this) {
            ${t.enumMap.entries.map((e) => 'case ${t.type.element.name}.${e.key.name}: return AppLocalizations.of'
              '(context).${t.enumKey.prefix.isEmpty ? e.key.name.unCapitalize() : '${t.enumKey.prefix.unCapitalize()}${e.key.name.capitalize()}'};\n').join()}
            default:
              break;
          }
          return AppLocalizations.of(context).${t.enumMap.keys.first.name};
        }
      }
      
      ''';
    }
    return result;
  }

  List<_LocalFields> _sortedEnums(ClassElement element) {
    assert(element is ClassElement);
    return element.fields
        .map<_LocalFields>((FieldElement e) => _LocalFields(
            type: e.type.isDartCoreList ? (e.type as ParameterizedType)?.typeArguments?.first : e.type,
            enumKey: e.metadata.isNotEmpty
                ? e.metadata
                    .map<EnumKey>((ElementAnnotation element) {
                      DartObject x = element.computeConstantValue();
                      return EnumKey(
                          prefix: x.getField('prefix')?.toStringValue(), exclude: x.getField('exclude')?.toBoolValue());
                    })
                    .where((EnumKey x) => x != null)
                    ?.toList()
                    ?.first
                : null))
        .toList()
        .toSet()
        .toList();
  }
}

class _LocalFields {
  _LocalFields({this.type, EnumKey enumKey}) : enumKey = enumKey ?? const EnumKey() {
    enumMap = _enumFieldsMap(type);
  }

  final DartType type;
  final EnumKey enumKey;
  Map<FieldElement, dynamic> enumMap;

  final _enumMapExpando = Expando<Map<FieldElement, dynamic>>();

  String toString() {
    return '>>> To String: $type/${enumKey.prefix}/${enumKey.exclude}';
  }

  Map<FieldElement, dynamic> _enumFieldsMap(DartType targetType) {
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

  @override
  bool operator ==(Object other) =>
      other is _LocalFields && other.type == type && other.enumKey.prefix.capitalize() == enumKey.prefix.capitalize();

  @override
  int get hashCode => type.hashCode;
}
