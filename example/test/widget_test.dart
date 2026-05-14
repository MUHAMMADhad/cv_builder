import 'package:flutter_test/flutter_test.dart';
import 'package:cv_builder/main.dart';

void main() {
  testWidgets('CV Builder smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CVBuilderApp());
  });
}