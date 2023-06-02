import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../widget/constants.dart';
// 'Authorization': 'Bearer 1|W8DIFtBJYZP9kFKcNbnLhEhrHiYSESxtsX5IFodx', // Replace with your authorization token
//       'Accept': 'application/json',


class TeacherCourseCreationScreen extends StatefulWidget {
  const TeacherCourseCreationScreen({super.key});

  @override
  _TeacherCourseCreationScreenState createState() =>
      _TeacherCourseCreationScreenState();
}

class _TeacherCourseCreationScreenState
    extends State<TeacherCourseCreationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late File _thumbnailImage;
  List<File> _videoFiles = [];
  bool _isUploading = false;

  Future<void> _uploadCourse() async {
    setState(() {
      _isUploading = true;
    });

    const url = 'http://192.168.0.15:8000/api/courses'; // Replace with your API endpoint
    final headers = {
      'Authorization': 'Bearer 1|W8DIFtBJYZP9kFKcNbnLhEhrHiYSESxtsX5IFodx', // Replace with your authorization token
      'Accept': 'application/json', // Set the Accept header for JSON parsing
    };

    // Create multipart request for course creation
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    // Add course title and description
    request.fields['title'] = _titleController.text;
    request.fields['description'] = _descriptionController.text;

    // Add thumbnail image
    if (_thumbnailImage != null) {
      var thumbnailImage = await http.MultipartFile.fromPath(
          'thumbnail', _thumbnailImage.path);
      request.files.add(thumbnailImage);
    }

    // Add video files
    if (_videoFiles.isNotEmpty) {
      for (var videoFile in _videoFiles) {
        var video =
            await http.MultipartFile.fromPath('videos[]', videoFile.path);
        request.files.add(video);
      }
    }

    // Send the request
    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        // Course creation successful
        // Reset the form and navigate to the course list
        _titleController.clear();
        _descriptionController.clear();
        _thumbnailImage = File('');
        _videoFiles.clear();

        setState(() {
          _isUploading = false;
        });
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Course Created Successfully.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      } else {
        // Course creation failed
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to create course. Please try again.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Error occurred during course creation
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to create course. Please try again.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = FilePicker.platform;
    FilePickerResult? result = await picker.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _thumbnailImage = File(result.files.first.path!);
      });
    }
  }

  Future<void> _pickVideos() async {
    final picker = FilePicker.platform;
    FilePickerResult? result = await picker.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      List<File> videoFiles = result.files.map((file) => File(file.path!)).toList();
      setState(() {
        _videoFiles.addAll(videoFiles);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: kInputDecoration('Course Title'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: kInputDecoration('Course Description'),
                maxLines: null,
              ),
              const SizedBox(height: 16),
              TextButton(
                style: myStyle(),
                onPressed: () => _pickImage(ImageSource.gallery),
                child: const Text('Pick Thumbnail Image'),
              ),
              const SizedBox(height: 16),
              TextButton(
                style: myStyle(),
                onPressed: () => _pickVideos(),
                child: const Text('Upload Videos'),
              ),
              const SizedBox(height: 16),
              TextButton(
                style: myStyle(),
                onPressed: _isUploading ? null : _uploadCourse,
                child: _isUploading
                    ? const CircularProgressIndicator()
                    : const Text('Create Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
