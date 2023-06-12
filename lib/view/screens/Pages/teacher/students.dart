import 'dart:convert';
import 'package:e_learning/view/screens/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EnrolledStudentsPage extends StatefulWidget {
   const EnrolledStudentsPage({super.key});
  @override
  _EnrolledStudentsPageState createState() => _EnrolledStudentsPageState();
}

class _EnrolledStudentsPageState extends State<EnrolledStudentsPage> {
  List<dynamic> enrolledStudents = [];

  @override
  void initState() {
    super.initState();
    fetchEnrolledStudents();
  }

  Future<void> fetchEnrolledStudents() async {
     final url = Uri.parse('http://192.168.0.15:8000/api/courses/{title}/enrolled-students');
  final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer 1|W8DIFtBJYZP9kFKcNbnLhEhrHiYSESxtsX5IFodx',
      },
    );

    

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        enrolledStudents = data['students'];
      });
    } else {
      print('Failed to fetch enrolled students. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        leading: GestureDetector(
          onTap: ()=>Get.back(),
          child: const Icon(Icons.arrow_back_ios_new)),
          title:  Text('Students',style: headingstyle(Get.isDarkMode?Colors.white:Colors.black),),
          centerTitle: true,
        
          foregroundColor: Get.isDarkMode?Colors.white:Colors.black
      ),
      body: Column(
        children: [
          const Text('Enrolled Students'),
          ListView.builder(
            itemCount: enrolledStudents.length,
            itemBuilder: (context, index) {
              final student = enrolledStudents[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(student['image']),
                ),
                title: Text(student['name']),
              );
            },
          ),
        ],
      ),
    );
  }
}
