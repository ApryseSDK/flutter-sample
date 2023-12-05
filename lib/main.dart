import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sample/thumbnail.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

void main() => runApp(MyApp());

const ASPECT_RATIO = 1224 / 1584;
const MARGIN = 5.0;

const PORTRAIT_NUM_COLUMNS = 2;
const LANDSCAPE_NUM_COLUMNS = 3;

final navigationColor = Platform.isIOS ? Color(0xffffffff) : Color(0xff48a1e0);
final titleColor = Platform.isIOS ? Color(0xff007aff) : Color(0xffffffff);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      PdftronFlutter.initialize("your_pdftron_license_key");
      if (mounted) {
        setState(() {
          _initialized = true;
        });
      }
    } on PlatformException {
      // stub
    }
  }

  void openDocument(String document) {
    // configure the viewer by setting the config fields
    Config config = new Config();
    PdftronFlutter.openDocument(document, config: config);
  }

  Widget getBody() {
    if (_initialized) {
      return SafeArea(child: Container(
        child: OrientationBuilder(builder: (context, orientation) {
          return GridView.builder(
            itemCount: thumbnailList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: orientation == Orientation.portrait
                    ? PORTRAIT_NUM_COLUMNS
                    : LANDSCAPE_NUM_COLUMNS,
                // crossAxisSpacing: SPACING,
                // mainAxisSpacing: SPACING,
                childAspectRatio: ASPECT_RATIO),
            itemBuilder: (BuildContext context, int index) {
              Thumbnail thumbnail = thumbnailList[index];
              return InkWell(
                  child: Container(
                    margin: EdgeInsets.all(MARGIN),
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
                      ],
                    ),
                    child: Image(image: AssetImage(thumbnail.assetPath)),
                  ),
                  onTap: () {
                    openDocument(thumbnail.documentUrl);
                  });
            },
          );
        }),
      ));
    } else {
      return Container(
          child: Align(
        alignment: Alignment
            .center, // Align however you like (i.e .centerRight, centerLeft)
        child: Text('PDFTron SDK not initialized.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'PDFTron Flutter Sample',
              style: TextStyle(color: titleColor),
            ),
            backgroundColor: navigationColor,
          ),
          body: getBody()),
    );
  }
}
