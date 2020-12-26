import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sample/thumbnail.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

const ASPECT_RATIO = 1224 / 1584;
const SPACING = 2.0;

const PORTRAIT_NUM_COLUMNS = 2;
const LANDSCAPE_NUM_COLUMNS = 3;

final navigationColor = Platform.isIOS ? Color(0xffffffff) : Color(0xff48a1e0);
final titleColor = Platform.isIOS ? Color(0xff007aff) : Color(0xffffffff);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _storagePermitted = Platform.isIOS;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    if (Platform.isAndroid) {
      askForPermission();
    }
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

  Future<void> askForPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    if (granted(permissions[PermissionGroup.storage]) && mounted) {
      setState(() {
        _storagePermitted = true;
      });
    }
  }

  bool granted(PermissionStatus status) {
    return status == PermissionStatus.granted;
  }

  void openDocument(String document) {
    // configure the viewer by setting the config fields
    Config config = new Config();
    PdftronFlutter.openDocument(document, config: config);
  }

  Widget getBody() {
    if (_initialized && _storagePermitted) {
      return OrientationBuilder(builder: (context, orientation) {
        return GridView.builder(
          itemCount: thumbnailList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait
                  ? PORTRAIT_NUM_COLUMNS
                  : LANDSCAPE_NUM_COLUMNS,
              crossAxisSpacing: SPACING,
              mainAxisSpacing: SPACING,
              childAspectRatio: ASPECT_RATIO),
          itemBuilder: (BuildContext context, int index) {
            Thumbnail thumbnail = thumbnailList[index];
            return InkWell(
              onTap: () {
                openDocument(thumbnail.documentUrl);
              },
              child: Image.asset(thumbnail.assetPath, fit: BoxFit.fitWidth),
            );
          },
        );
      });
    } else {
      return Container(
          child: Align(
        alignment: Alignment
            .center, // Align however you like (i.e .centerRight, centerLeft)
        child: Text(_initialized
            ? 'Storage permission required.'
            : 'PDFTron SDK not initialized.'),
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
