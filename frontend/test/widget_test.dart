import 'package:ai_business_manager/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('renders splash screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: AiBusinessManagerApp()));
    expect(find.text('AI Business Suite'), findsOneWidget);
    expect(find.text('Launch prototype'), findsOneWidget);
  });
}
