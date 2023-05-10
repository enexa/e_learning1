// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VideoUploader extends StatefulWidget {
  final File file;

  const VideoUploader({super.key, required this.file});

  @override
  _VideoUploaderState createState() => _VideoUploaderState();
}

class _VideoUploaderState extends State<VideoUploader> {
  bool _uploading = false;

  void _uploadFile() async {
    setState(() {
      _uploading = true;
    });

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://example.com/api/videos'),
    );
    request.files.add(await http.MultipartFile.fromPath('video', widget.file.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Video uploaded successfully.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to upload video.'),
        backgroundColor: Colors.red,
      ));
    }

    setState(() {
      _uploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _uploading ? null : _uploadFile,
      child: _uploading ? const CircularProgressIndicator() : const Text('Upload Video'),
    );
  }
}
