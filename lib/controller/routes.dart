

import 'package:e_learning/view/screens/Pages/student/askforum.dart';
import 'package:e_learning/view/screens/Pages/teacher/post.dart';
import 'package:e_learning/view/screens/Pages/teacher/uploadpdf.dart';



import '../view/screens/Pages/student/Blog.dart';

import '../view/screens/Pages/student/class.dart';
import '../view/screens/Pages/student/forum.dart';
import '../view/screens/Pages/student/home1.dart';
import '../view/screens/Pages/student/mycourse.dart';
import '../view/screens/Pages/student/student_profile.dart';
import '../view/screens/Pages/teacher/Course.dart';
import '../view/screens/Pages/teacher/home_screen.dart';


import '../view/screens/Pages/teacher/profile.dart';
import '../view/screens/Pages/teacher/schedule_stream.dart';



final List<Map<String, dynamic>> pageDetails = [
  {
    'pageName': CourseListPage(),
  },
  {
    'pageName':     PdfScreen(),
  },
  {        
    'pageName': const Blog(),
  },
  {
    'pageName': const ForumScreen(),
  },
  {
    'pageName': const Student_Profile(),
  },
    
];
final List<Map<String, dynamic>> navigation = [
  {
    'pageName': const Screen(),
  },
  {
    'pageName': const PostForm(),
  },
  {
    'pageName': const MyStream(),
  },
  {
    'pageName':  const TeacherCourseCreationScreen(),
  },
   {
    'pageName': const Profile(),
  },
];
