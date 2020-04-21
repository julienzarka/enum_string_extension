/// Provides annotation class to use with
/// [enum_string_extension_gen](https://pub.dev/packages/enum_string_extension_gen).
library enum_string_extension;

/// Annotation used to indicate that the `EnumString` extension should be generated.
const enumString = EnumString();

class EnumString {
  /// Creates a new [EnumString] instance.
  const EnumString();
}
