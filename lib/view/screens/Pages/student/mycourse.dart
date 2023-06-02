// ignore_for_file: library_private_types_in_public_api

import 'package:e_learning/view/screens/Pages/student/vedeo_player.dart';
import 'package:e_learning/view/screens/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../models/user.dart';
import '../../widget/constants.dart';
import 'alert.dart';

class Course {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
 final List<MyVideo> video; 

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.video,
  });
}
class MyVideo{
   final String videoUrl;

  MyVideo( {required this.videoUrl});

}

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  List<Course> courses = [];
  

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

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Course> fetchedCourses = [];

      for (var courseData in data) {
        final List<String> videoUrls = List<String>.from(courseData['video']);

        final videos = videoUrls.map((url) => MyVideo(videoUrl: url)).toList();

        final course = Course(
          id: courseData['id'].toString(),
          title: courseData['title'],
          description: courseData['description'],
          thumbnail: courseData['thumbnail'],
          video: videos,
        );
        fetchedCourses.add(course);
      }

      setState(() {
        courses = fetchedCourses;
      });
    } else {
      // Handle non-200 status code
      print('Failed to fetch courses. Status code: ${response.statusCode}');
    }
  } catch (error) {
    // Handle error during the HTTP request
    print('Error fetching courses: $error');
  }
}



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: SafeArea(
        child: Scaffold(
           backgroundColor: context.theme.backgroundColor,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 133,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(
                              top: 20.0, bottom: 0.0, left: 10.0),
                       
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                           
                            validator: (val) =>
                                val!.isEmpty ? 'Invalid email address' : null,
                            decoration: kInputDecoration('Search Courses')),
                        ),
                       
                      
               
                   
                   
                    Padding(
                      padding: const EdgeInsets.only(left:18.0),
                      child: Text("Courses", style: subheading(Get.isDarkMode?Colors.white:Colors.black)),
                    ),
              
                         
                        SizedBox(
                          height: 280,
                        
                         
                            child: ListView.builder(
                              itemCount: courses.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final course = courses[index];
                                return Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    height: 180,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return VideoPage(
                                                videos: course.video,
                                                title: course.title,
                                                 description: course.description,
                                                 thumbnail: course.thumbnail,
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
                                              height: 180,
                                              width: 180,
                                            ),
                                            const SizedBox(height: 10),
                                            Column(
                                              children: [
                                                Text(
                                                  course.title,
                                                  style: subtitlestyle(Get.isDarkMode?Colors.white:Colors.black)
                                                ),
                                              ],
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
                      
                        
                        Padding(
                          padding: const EdgeInsets.only(left:18.0),
                          child: Text("Recent", style: subheading(Get.isDarkMode?Colors.white:Colors.black)),
                        ),
                     
                        SizedBox(
                          height: 90,
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
                                             videos: course.video,
                                              title: course.title,
                                              description:course.description,
                                              thumbnail:course.thumbnail,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
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
                                      child: Row(
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
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text(course.title,style: subtitlestyle(Get.isDarkMode?Colors.white:Colors.black)),
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
      ),
    );
  }
}




