import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sample/thumbnail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_sample/main.dart' as app;
import 'package:pdftron_flutter/pdftron_flutter.dart';

// Test for the sample app.
void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  List<String> calls = <String>[];

  setUpAll(() async {
    // Used to track method calls.
    MethodChannel('pdftron_flutter').setMockMethodCallHandler( (MethodCall call) async {
      calls.add(call.method);
    });
  });

  tearDown(() {
    // Clears list after each test.
    calls.clear();
  });

  // Destroys the method call tracker after all tests have ran.
  tearDownAll(() async {
    MethodChannel('pdftron_flutter').setMockMethodCallHandler(null);
  });

  testWidgets('Check widget hierarchy of app', (WidgetTester tester) async {
    Widget myApp = app.MyApp();
    await tester.pumpWidget(myApp);

    expect(find.text("PDFTron Flutter Sample"), findsOneWidget);
    
    final bodyFinder = find.byKey(Key('body'));
    expect(bodyFinder, findsOneWidget);
    
    // Body widget is SafeArea type if app is initialized and storage is permitted.
    final body = tester.firstWidget(bodyFinder);
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

      expect(find.byType(Text), findsNWidgets(2));
    }
  });

  testWidgets("Opening Thumbnail", (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(app.MyApp());
      await tester.pump();
      expect(find.byType(InkWell), findsWidgets);

      // Chooses a random thumbnail to select.
      Random rng = Random();

      // 6 is used instead of thumbnailList.length as that is the number of thumbnails visible upon loading.
      int index = rng.nextInt(6); 
      Finder thumbnail = find.byKey(ValueKey(thumbnailList[index].documentUrl));

      // Opens the selected thumbnail.
      await tester.tap(thumbnail);
      await tester.pump();

      // Tests to ensure that the PdftronFlutter method were called.
      await Future.delayed(Duration(seconds: 2), () async {
        expect(calls.contains(Functions.openDocument), true);
      });
    });
  }, variant: TargetPlatformVariant({TargetPlatform.android, TargetPlatform.iOS}));
}

