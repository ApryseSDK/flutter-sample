// This is a basic Flutter integration test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_sample/thumbnail.dart';

import 'package:flutter_sample/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Finds child instances of Flutter Sample app', (WidgetTester tester) async {
    Widget myApp = app.MyApp();
    await tester.pumpWidget(myApp);

    expect(find.text('PDFTron Flutter Sample'), findsOneWidget);    

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
    var orientationBuilderWidget = OrientationBuilder(builder: (context, orientation) {

    }
    );
    await tester.pumpWidget(InkWell(child: orientationBuilderWidget));
    expect(find.byWidget(orientationBuilderWidget), findsOneWidget);
  });
  
  testWidgets('Finds child container instance of InkWell', (WidgetTester tester) async {
    // underscored fields/classes/methods are only available in the .dart file where they are defined
    int index = 0;
    Thumbnail thumbnail = thumbnailList[index];
    var inkWellContainerWidget = Container(
      margin: EdgeInsets.all(app.MARGIN),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(thumbnail.assetPath),
          fit: BoxFit.fitWidth,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(2, 2), // changes position of shadow
          ),
        ]),
      );
      await tester.pumpWidget(InkWell(child: inkWellContainerWidget));
      expect(find.byWidget(inkWellContainerWidget), findsOneWidget);
  });*/

  testWidgets('Finds child instances when state not initialized or permission denied', (WidgetTester tester) async {
    const textWidget = Text('Storage permission required.', textDirection: TextDirection.ltr);
    await tester.pumpWidget(Align(alignment: Alignment.center, child: textWidget));
    expect(find.byWidget(textWidget), findsOneWidget);

    const alignWidget = Align(alignment: Alignment.center, child: textWidget);
    await tester.pumpWidget(Container(child: alignWidget));
    expect(find.byWidget(alignWidget), findsOneWidget);
  });
  
}