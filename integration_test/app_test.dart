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

    expect(find.text('PDFTron Flutter Sample'), findsOneWidget);

    final materialAppFinder = find.descendant(of: find.byWidget(myApp), matching: find.byType(MaterialApp)).first;
    expect(materialAppFinder, findsOneWidget);

    final scaffoldFinder = find.descendant(of: materialAppFinder, matching: find.byType(Scaffold)).first;
    expect(scaffoldFinder, findsOneWidget);

    final appBarFinder = find.descendant(of: scaffoldFinder, matching: find.byType(AppBar)).first;
    expect(appBarFinder, findsOneWidget);

    final textFinder = find.descendant(of: appBarFinder, matching: find.byType(Text)).first;
    expect(textFinder, findsOneWidget);
    
    var bodyFinder;
    try {
      bodyFinder = find.descendant(of: scaffoldFinder, matching: find.byType(SafeArea)).first;
      expect(bodyFinder, findsOneWidget);
    } catch (e) {
      bodyFinder = find.descendant(of: scaffoldFinder, matching: find.byType(Container)).first;
    }
    expect(bodyFinder, findsOneWidget);
    
    if (bodyFinder.first is SafeArea) {
      debugPrint(bodyFinder.evaluate().toString());

      final outContainerFinder = find.descendant(of: bodyFinder, matching: find.byType(Container)).first;
      expect(outContainerFinder, findsOneWidget);

      final orientationBuilderFinder = find.descendant(of: bodyFinder, matching: find.byType(OrientationBuilder)).first;
      expect(orientationBuilderFinder, findsOneWidget);

      // Check if orientationBuilder returns GridView
      final inkWellBuilder = find.descendant(of: orientationBuilderFinder, matching: find.byType(InkWell)).first;
      expect(inkWellBuilder, findsOneWidget);

      final containerBuilder = find.descendant(of: inkWellBuilder, matching: find.byType(Container)).first;
      expect(containerBuilder, findsOneWidget);

      final imageBuilder = find.descendant(of: containerBuilder, matching: find.byType(Image)).first;
      expect(imageBuilder, findsOneWidget);

    } else if (bodyFinder.first is Container) {
      final alignFinder = find.descendant(of: bodyFinder, matching: find.byType(Align)).first;
      expect(alignFinder, findsOneWidget);

      final alignTextFinder = find.descendant(of: alignFinder, matching: find.byType(Text)).first;
      expect(alignTextFinder, findsOneWidget);
    }

    debugPrint("Test completing: Finds child instances of Flutter Sample app");
  });

  testWidgets('Finds child instances when state not initialized or permission denied', (WidgetTester tester) async {
    const textWidget = Text('Storage permission required.', textDirection: TextDirection.ltr);
    await tester.pumpWidget(Align(alignment: Alignment.center, child: textWidget));
    expect(find.byWidget(textWidget), findsOneWidget);

    const alignWidget = Align(alignment: Alignment.center, child: textWidget);
    await tester.pumpWidget(Container(child: alignWidget));
    expect(find.byWidget(alignWidget), findsOneWidget);

    debugPrint("Test completing: Finds child instances when state not initialized or permission denied");
  });
  
}