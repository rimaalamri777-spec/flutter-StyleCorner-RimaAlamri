import 'package:flutter_test/flutter_test.dart';
import 'package:style_corner/main.dart';

void main() {
  testWidgets('الشاشة الافتتاحية تظهر اسم التطبيق', (WidgetTester tester) async {
    await tester.pumpWidget(const StyleCornerApp());

    expect(find.text('ركن الأناقة'), findsOneWidget);
    expect(find.text('Style Corner'), findsOneWidget);
  });
}
