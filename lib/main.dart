import 'dart:async';
import 'dart:io' show Directory, File;
import 'package:flutter/material.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:path_provider/path_provider.dart';

/*
* Widget version
* */

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Viewer(),
    );
  }
}

class Viewer extends StatefulWidget {
  @override
  _ViewerState createState() => _ViewerState();
}

class _ViewerState extends State<Viewer> {
  final ValueNotifier<DocumentViewController> _documentViewController =
      ValueNotifier<DocumentViewController>(null);
  Future<Directory> directory;

  @override
  void initState() {
    super.initState();
    PdftronFlutter.initialize("your_pdftron_license_key");
    directory = _getLocalDirectory();
  }

  Future<Directory> _getLocalDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Directory>(
        future: directory,
        builder: (BuildContext context, AsyncSnapshot<Directory> result) {
          return Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDocumentButton('doc1.pdf'),
              ],
            )),
          );
        });
  }

  Widget _buildDocumentButton(String title) {
    return SizedBox(
      height: 100,
      width: 200,
      child: RaisedButton(
          color: Colors.green,
          onPressed: () async {
            final _pdfDocumentView =
                PdfDocumentView((DocumentViewController controller) {
              _documentViewController.value = controller;
              _onDocumentViewCreated(controller, title);
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => _pdfDocumentView));
          },
          child: Text(title, style: TextStyle(fontSize: 20))),
    );
  }

  void _onDocumentViewCreated(
      DocumentViewController controller, String fileName) async {
    startLeadingNavButtonPressedListener(() async {
      Navigator.of(context).pop();
    });

    var config = Config();
    config.singleLineToolbar = true;
    await _documentViewController.value.openDocument(
        'https://pdftron.s3.amazonaws.com/downloads/pl/PDFTRON_mobile_about.pdf',
        config: config);

    final annotationsPayload = '''
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
               <fields />

               </xfdf>
    ''';

    _documentViewController.value.importAnnotationCommand(annotationsPayload);
  }
}

class PdfDocumentView extends StatelessWidget {
  const PdfDocumentView(this._onViewCreated);
  final Function(DocumentViewController contoller) _onViewCreated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: DocumentView(
            onCreated: _onViewCreated,
          )),
    );
  }
}
