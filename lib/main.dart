import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdfx/pdfx.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Viewer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> list=[];

  Future<void> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
       var filePath = result.files.first.path;

       list.add(filePath!);
       print("FilePath: ${filePath.runtimeType}");
       print("FilePath: ${list.runtimeType}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_open),
            onPressed: pickPdfFile,
          )
        ],
      ),
      body:list.isNotEmpty?ListView.builder(
          itemCount: list.length,
          itemBuilder: (context,index){
        return  PdfView(
          scrollDirection: Axis.vertical,
            controller: PdfController(
              document: PdfDocument.openFile(list[index])));


           }):Center(child: Text("No Selected"))

    );
  }
}