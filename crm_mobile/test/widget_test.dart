import 'package:flutter_test/flutter_test.dart';

import 'package:crm_mobile/main.dart';

void main() {
  testWidgets('CRM dashboard renders', (WidgetTester tester) async {
    await tester.pumpWidget(const CrmApplication());

    expect(find.text('CRM Application'), findsOneWidget);
    expect(find.text('Dashboard'), findsOneWidget);
  });
}
