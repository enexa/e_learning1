

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/files.dart';
import 'package:http/http.dart' as http;

class PdfUpload extends StatefulWidget {
  const PdfUpload({super.key});

  @override
  State<PdfUpload> createState() => _PdfUploadState();
}

class _PdfUploadState extends State<PdfUpload> {
 String? _selectedCategory;
String? _selectedYear;
FilePickerResult? _filePickerResult;

Future<void> _pickPDFFile() async {
  _filePickerResult = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );
}

Future<void> _uploadPDFFile() async {
  if (_selectedCategory == null || _selectedYear == null || _filePickerResult == null) {
    // Display an error message
    return;
  }

  final String category = _selectedCategory!;
  final String year = _selectedYear!;
  final String fileName = _filePickerResult!.files.single.name;
  final Uint8List bytes = _filePickerResult!.files.single.bytes!;

  final http.MultipartRequest request = http.MultipartRequest(
    'POST',
    Uri.parse('http://10.42.0.1:8000/api/pdfupload'),
  )
    ..fields['category'] = category
    ..fields['year'] = year
    ..files.add(http.MultipartFile.fromBytes(
      'pdf_file',
      bytes,
      filename: fileName,
    ));

  final http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // Display a success message
  } else {
    // Display an error message
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
   
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: _selectedCategory,
            hint: Text('Select a category'),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
            items: ['IS', 'SW', 'CS', 'IT']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          DropdownButton<String>(
            value: _selectedYear,
            hint: Text('Select a year'),
            onChanged: (String? newValue) {
              setState(() {
                _selectedYear = newValue;
              });
            },
            items: ['1', '2', '3', '4']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _pickPDFFile,
            child: Text('Pick a PDF file'),
          ),
          SizedBox(height: 16),
          if (_filePickerResult != null)
            Text(
              'Selected file: ${_filePickerResult!.files.single.name}',
            ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _uploadPDFFile,
            child: Text('Upload PDF file'),
          ),
        ],
      ),
    ),
  );
}

}