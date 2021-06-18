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

    final titleFinder = find.text('PDFTron Flutter Sample');
    expect(titleFinder, findsOneWidget);
    
    var bodyFinder = find.byKey(Key('body'));
    expect(bodyFinder, findsOneWidget);
    var body = tester.firstWidget(bodyFinder);
    
    // Body widget is SafeArea type if app is initialized and storage is permitted.
    if (body is SafeArea) {
      final inkWellFinder = find.descendant(of: bodyFinder, matching: find.byType(InkWell));
      expect(inkWellFinder, findsWidgets);

      final imageFinder = find.descendant(of: inkWellFinder.first, matching: find.byType(Image));
      expect(imageFinder, findsOneWidget);

    } else {
      // Body widget is Container type if app is not initialized or storage is not permitted.      
      expect(body.runtimeType, Container);
      
      final alignFinder = find.descendant(of: bodyFinder, matching: find.byType(Align));
      expect(alignFinder, findsOneWidget);

      final textFinder = find.descendant(of: alignFinder, matching: find.byType(Text));
      expect(textFinder, findsOneWidget);

      Text text = tester.firstWidget<Text>(textFinder);
      assert(text.data == 'Storage permission required.' || text.data == 'PDFTron SDK not initialized.');
    }
  });  
}