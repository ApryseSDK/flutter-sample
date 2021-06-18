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

  testWidgets('Check widget hierarchy of app', (WidgetTester tester) async {
    Widget myApp = app.MyApp();
    await tester.pumpWidget(myApp);

    final materialAppFinder = find.descendant(of: find.byWidget(myApp), matching: find.byType(MaterialApp));
    expect(materialAppFinder, findsOneWidget);

    final scaffoldFinder = find.byWidgetPredicate((widget) => widget is Scaffold 
      && (widget.body is SafeArea || widget.body is Container));
    expect(scaffoldFinder, findsOneWidget);

    final appBarFinder = find.byWidget(tester.firstWidget<Scaffold>(scaffoldFinder).appBar!);
    expect(appBarFinder, findsOneWidget);

    final textFinder = find.byWidget(tester.firstWidget<AppBar>(appBarFinder).title!);
    expect(textFinder, findsOneWidget);

    Text text = tester.firstWidget<Text>(textFinder);
    expect(text.data, 'PDFTron Flutter Sample');

    var scaffold = tester.firstWidget<Scaffold>(scaffoldFinder);
    var body = scaffold.body;

    var bodyFinder = find.byWidget(scaffold.body!);
    expect(bodyFinder, findsOneWidget);
    
    // Body widget is SafeArea type if app is initialized and storage is permitted.
    if (body is SafeArea) {
      final safeAreaContainerFinder = find.descendant(of: bodyFinder, matching: find.byType(Container));
      expect(safeAreaContainerFinder, findsWidgets);

      final orientationBuilderFinder = find.descendant(of: safeAreaContainerFinder.first, matching: find.byType(OrientationBuilder));
      expect(orientationBuilderFinder, findsOneWidget);

      final inkWellFinder = find.descendant(of: orientationBuilderFinder, matching: find.byType(InkWell));
      expect(inkWellFinder, findsWidgets);

      final containerFinder = find.descendant(of: inkWellFinder.first, matching: find.byType(Container));
      expect(containerFinder, findsOneWidget);

      final imageFinder = find.descendant(of: containerFinder.first, matching: find.byType(Image));
      expect(imageFinder, findsOneWidget);

    } else {
      // Body widget is Container type if app is not initialized or storage is not permitted.      
      expect(body.runtimeType, Container);
      
      final alignFinder = find.descendant(of: bodyFinder, matching: find.byType(Align));
      expect(alignFinder, findsOneWidget);

      final alignTextFinder = find.descendant(of: alignFinder, matching: find.byType(Text));
      expect(alignTextFinder, findsOneWidget);
    }
  });  
}