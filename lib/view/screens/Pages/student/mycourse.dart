// ignore_for_file: library_private_types_in_public_api

import 'package:e_learning/view/screens/Pages/student/vedeo_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../models/user.dart';
import 'alert.dart';

class Course {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String video;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.video,
  });
}

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  List<Course> courses = [];
   User? user;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('http://192.168.0.15:8000/api/courses');
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer 1|W8DIFtBJYZP9kFKcNbnLhEhrHiYSESxtsX5IFodx',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Course> fetchedCourses = [];

      for (var courseData in data) {
        final course = Course(
          id: courseData['id'].toString(),
          title: courseData['title'],
          description: courseData['description'],
          thumbnail: courseData['thumbnail'],
          video: courseData['video'],
        );
        fetchedCourses.add(course);
      }

      setState(() {
        courses = fetchedCourses;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 133,
                  child: Column(
                    children: [
                       Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(
                            top: 20.0, bottom: 0.0, left: 10.0),
                        child:  Text(
                          textAlign: TextAlign.start,
                          'Hello\n ${user!.name}',
                          style:const TextStyle(
                              color: Color.fromARGB(255, 29, 82, 31),
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          decoration: InputDecoration(
                            iconColor: const Color.fromARGB(255, 29, 82, 31),
                            fillColor: const Color.fromARGB(255, 29, 82, 31),

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: Colors.green)),
                            prefixIcon: const Icon(Icons.search),
                            // suffixIcon: IconButton(onPressed:q, icon: Icons.clear),
                            hintText: ('search  for Courses'),
                          ),
                          // onChanged: searchBook,
                          // onEditingComplete: () =>
                          //     setState(() => isNotSearching = true),
                        ),
                      ),
                       SizedBox(
                        height: 100,
                        child: ListView.builder(
                          itemCount: courses.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final course = courses[index];
                            return Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                height: 70,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return VideoPage(
                                            videoUrl: course.video,
                                            title: course.title,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 2,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                              image: NetworkImage(course.thumbnail),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          height: 60,
                                          width: 60,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          course.title,
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 29, 82, 31),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          course.description,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: courses.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final course = courses[index];
                            return Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                height: 200,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return VideoPage(
                                            videoUrl: course.video,
                                            title: course.title,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 2,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                              image: NetworkImage(course.thumbnail),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          height: 200,
                                          width: 200,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          course.title,
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 29, 82, 31),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          course.description,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




