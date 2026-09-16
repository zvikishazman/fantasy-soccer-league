import 'package:fantasy_soccer_league/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the portfolio dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const FantasySoccerApp());

    expect(find.text('Good evening, Zvi'), findsOneWidget);
    expect(find.text('Current squad'), findsOneWidget);
    expect(find.text('Top managers'), findsOneWidget);
  });
}
