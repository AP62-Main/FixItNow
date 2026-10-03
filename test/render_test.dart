import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fixitnow/main.dart';
import 'package:fixitnow/screens/main_layout.dart';
import 'package:fixitnow/screens/home_screen.dart';

void main() {
  testWidgets('Test sizes in widget tree', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const ProviderScope(
        child: FixItNowApp(),
      ),
    );
    await tester.pump();

    final appFinder = find.byType(MaterialApp);
    final mainFinder = find.byType(MainLayout);
    final homeFinder = find.byType(HomeScreen);

    print('MaterialApp size: ${(tester.renderObject(appFinder.first) as RenderBox).size}');
    print('MainLayout size: ${(tester.renderObject(mainFinder.first) as RenderBox).size}');
    print('HomeScreen size: ${(tester.renderObject(homeFinder.first) as RenderBox).size}');
  });
}
