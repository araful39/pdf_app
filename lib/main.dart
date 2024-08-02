
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
void main() {
  runApp(const MaterialApp(
    title: 'Syncfusion PDF Viewer Demo',
    home: HomePage(),
  ));
}

/// Represents Homepage for Navigation
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void openFile(PlatformFile file){
    OpenFile.open(file.path);
  }
  Future<File> saveFilePermanently(PlatformFile file)async{
final appStorage=await getApplicationDocumentsDirectory();
final newFile=File("${appStorage.path}/${file.name}");
return File(file.path!).copy(newFile.path);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),

      ),
      body: Center(
        child: ElevatedButton(onPressed: ()async{
          final result= await FilePicker.platform.pickFiles();
if(result==null) return;
final file=result.files.first;
print("Name:${file.name}");
print("Bytes:${file.bytes}");
print("Size:${file.size}");
print("Extexsion:${file.extension}");
print("Path:${file.path}");
print("Path:${file.identifier}");
openFile(file);
      final newFile=    saveFilePermanently(file);
        }, child: const Text("Pick File")),
      ),
    );
  }
}
