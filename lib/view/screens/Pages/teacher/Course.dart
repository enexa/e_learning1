 import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../widget/constants.dart';

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
  late File _videoFile;
  bool _isUploading = false;
  bool isLoading=true;

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

    // Add video file
    if (_videoFile != null) {
      var videoFile =
          await http.MultipartFile.fromPath('video', _videoFile.path);
      request.files.add(videoFile);
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
      _videoFile = File('');

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
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _thumbnailImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      setState(() {
        _videoFile = File(pickedVideo.path);
      });
    }
  }
  Widget buildShimmeringContainer(double height, double width) {
    return Shimmer.fromColors(

          period: const Duration(milliseconds: 300),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }
   Widget BuildShimmer() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              buildShimmeringContainer(70, 70),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildShimmeringContainer(12, double.infinity),
                    const SizedBox(height: 5),
                    buildShimmeringContainer(12, 150),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading?BuildShimmer():
      SingleChildScrollView(
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
                decoration:kInputDecoration('Course Description'),
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
                onPressed: () => _pickVideo(),
                child: const Text('Upload Video'),
              ),
              const SizedBox(height: 16),
              TextButton(
                 style: myStyle(),
                onPressed: _isUploading ? null : _uploadCourse,
                child: _isUploading ? const CircularProgressIndicator() : const Text('Create Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}