// This is a basic Flutter integration test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_sample/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Finds child instances of Flutter Sample app', (WidgetTester tester) async {
    Widget myApp = app.MyApp();
    await tester.pumpWidget(myApp);

    //expect(find.text('Storage permission required.'), findsOneWidget);

    final materialAppFinder = find.descendant(of: find.byWidget(myApp), matching: find.byType(MaterialApp));
    expect(materialAppFinder, findsOneWidget);

    final scaffoldFinder = find.descendant(of: materialAppFinder, matching: find.byType(Scaffold));
    expect(scaffoldFinder, findsOneWidget);

    final appBarFinder = find.descendant(of: scaffoldFinder, matching: find.byType(AppBar));
    expect(appBarFinder, findsOneWidget);

    final textFinder = find.descendant(of: appBarFinder, matching: find.byType(Text));
    expect(textFinder, findsOneWidget);
  });
  /*
  testWidgets('Finds child instances when state initialized and permission granted', (WidgetTester tester) async {
  });

  testWidgets('Finds child instances when state not initialized or permission denied', (WidgetTester tester) async {
    const textWidget = Text('Storage permission required.');
    // Provide the textWidget to Align.
    await tester.pumpWidget(Align(alignment: Alignment.center, child: textWidget));
    // Search for the textWidget in the tree and verify it exists.
    expect(find.byWidget(textWidget), findsOneWidget);

    const alignWidget = Align(alignment: Alignment.center, child: Text('Storage permission required.'));
    // Provide the alignWidget to the Container.
    await tester.pumpWidget(Container(child: alignWidget));
    // Search for the alignWidget in the tree and verify it exists.
    expect(find.byWidget(alignWidget), findsOneWidget);
  });
  */
}