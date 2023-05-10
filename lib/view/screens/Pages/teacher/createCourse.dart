// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: library_private_types_in_public_api, file_names

import'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerWidget extends StatefulWidget {
  final ValueChanged<File> onFileSelected;

  const FilePickerWidget({super.key, required this.onFileSelected});

  @override
  _FilePickerWidgetState createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  File? _file;

void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
      widget.onFileSelected(_file!);
    }
}





  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _pickFile,
          child: const Text('Select Video'),
        ),
        if (_file != null) Text('Selected video: ${_file!.path}'),
      ],
    );
  }
}
