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

