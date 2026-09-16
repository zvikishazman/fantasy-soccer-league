import 'package:fantasy_soccer_league/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the portfolio dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const FantasySoccerApp());

    expect(find.text('Good evening, Zvi'), findsOneWidget);
    expect(find.text('Current squad'), findsOneWidget);
    expect(find.text('Top managers'), findsOneWidget);
  });

  testWidgets('mobile navigation reaches each view without layout exceptions',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const FantasySoccerApp());
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Squad'));
    await tester.pumpAndSettle();
    expect(find.text('My squad'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Table'));
    await tester.pumpAndSettle();
    expect(find.text('League standings'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Admin'));
    await tester.pumpAndSettle();
    expect(find.text('Read-only portfolio demonstration'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
