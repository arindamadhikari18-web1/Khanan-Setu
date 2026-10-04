import 'package:flutter_test/flutter_test.dart';

import 'package:khanan_setu/main.dart';

void main() {
  testWidgets('Khanan Setu app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const KhananSetuApp());

    expect(find.byType(KhananSetuApp), findsOneWidget);
  });
}