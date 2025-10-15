// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/expense_provider.dart';

void main() {
  testWidgets('Expense Tracker App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ExpenseProvider(),
        child: const ExpenseTrackerApp(),
      ),
    );

    // Verify that the welcome screen is displayed.
    expect(find.text('Expense Tracker'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
  });
}
