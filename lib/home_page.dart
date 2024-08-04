import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController controller = PdfViewerController();

  File? file;
  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf']
    );

    if (result != null) {
      print(" Select File");
      file = File(result.files.first.path!);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raju PDF File Viewer'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.zoom_in,
            ),
            onPressed: () {

               controller.zoomLevel = 1;

            },
          ),
          IconButton(
            icon: Icon(
              Icons.zoom_out,
            ),
            onPressed: () {
              controller.zoomLevel = 2;
            },
          ),
          IconButton(
              onPressed: () {
                getFile();
                // _pdfViewerKey.currentState?.openBookmarkView();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: file == null
          ? const Center(
              child: Text("No Selected"),
            )
          : SfPdfViewer.file(
              file!,
              controller: controller,
              key: _pdfViewerKey,
            ),
    );
  }
}
