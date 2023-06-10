// ignore_for_file: library_private_types_in_public_api

import 'package:e_learning/view/screens/Pages/student/vedeo_player.dart';
import 'package:e_learning/view/screens/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
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
  bool isLoading = true;
  bool isSearching = false;
  List<Course> filteredCourses = [];
  bool isEnrolled = false;



  @override
  void initState() {
    super.initState();
    fetchData();
  }
Future<void> enrollInCourse(String courseTitle) async {
  final url = 'http://192.168.0.15:8000/api/courses/$courseTitle/enroll';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
       'Authorization': 'Bearer 1|W8DIFtBJYZP9kFKcNbnLhEhrHiYSESxtsX5IFodx',
    },
  );

  if (response.statusCode == 200) {
    setState(() {
      isEnrolled = true;
    });
    print('Enrollment successful');
  } else {
    print('Enrollment failed with status code: ${response.statusCode}');
    print('Error message: ${response.body}');
  }
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
        isLoading=false;
      });
    } else {
     isLoading=false;
      print('Failed to fetch courses. Status code: ${response.statusCode}');
    }
  } catch (error) {
    // Handle error during the HTTP request
    print('Error fetching courses: $error');
  }
}
Widget ShimmerWidgets(){
  return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 0),
      child: ListView(
        children: [
          SizedBox(
            child: Shimmer.fromColors(
              period: const Duration(milliseconds: 3000),

              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
               decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
              width: double.infinity,
              height: 180,
             
            ),
          ),
          const SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
               decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
              width: double.infinity,
              height: 90,
             
            ),
          ),
        
        ],
      ),
    );
}
 Widget buildShimmeringContainer(double height, double width) {
    return Shimmer.fromColors(
      period:  const Duration(milliseconds: 3000),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }

  Widget buildShimmeringListView() {
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
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: SafeArea(
        child: Scaffold(
           backgroundColor: context.theme.backgroundColor,
          body: isLoading ? buildShimmeringListView() :
          SingleChildScrollView(
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
                          onChanged: (value) {
                        setState(() {
                          isSearching = value.isNotEmpty;
                          filteredCourses = courses.where((course) =>
                        course.title.toLowerCase().contains(value.toLowerCase())).toList();
                         });
                                   },
                               validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
                              decoration: kInputDecoration('Search Courses'),
                              ),

                        ),
                       
                      
               
                   
                   
                    Padding(
                      padding: const EdgeInsets.only(left:18.0),
                      child: Text("Courses", style: subheading(Get.isDarkMode?Colors.white:Colors.black)),
                    ),
              
                         
                        SizedBox(
                          height: 280,
                        
                         
                            child: ListView.builder(
                              
                             itemCount: isSearching ? filteredCourses.length : courses.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                               final course = isSearching ? filteredCourses[index] : courses[index];
                                return Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    height: 180,
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
                                         
                                          Row(
                                            children: [
                                               Text(
                                                course.title,
                                                style: subtitlestyle(blackclr)
                                              ),
                                               SizedBox(width: 12,),
                                              kTextButton((isEnrolled ? 'Learn' : 'Enroll'), () {
                                                enrollInCourse(course.title);
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
                     
                                             }),
                                            
                                             
                                            ],
                                          ),
                                    
                                         
                                        ],
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
                                            child: Text(course.title,style: subtitlestyle(blackclr)),
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

class ShimmerWidget extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 0),
      child: ListView(
        children: [
          SizedBox(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
               decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
              width: double.infinity,
              height: 180,
             
            ),
          ),
          const SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
               decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
              width: double.infinity,
              height: 90,
             
            ),
          ),
        
        ],
      ),
    );
  }
}



