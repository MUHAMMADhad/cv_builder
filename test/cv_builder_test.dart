import 'package:flutter_test/flutter_test.dart';
import 'package:cv_builder/cv_builder.dart';

void main() {
  test('CVModel serializes correctly', () {
    final cv = CVModel();
    cv.basics.name = 'John Doe';
    final json = cv.toJson();
    expect(json.contains('John Doe'), true);
  });
}
