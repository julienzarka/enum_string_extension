import 'package:enum_string_extension/enum_string_extension.dart';
import 'package:test/test.dart';

import '../example/example.dart';

void main() {
  test('annotation exists', () {
    final annotation = const SimpleObject();
    expect(annotation is EnumString, true);
  });
}
