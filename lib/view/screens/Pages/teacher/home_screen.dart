// ignore_for_file: unused_field, prefer_final_fields

import 'package:e_learning/view/screens/Pages/teacher/post_screen.dart';
import 'package:flutter/material.dart';


import 'profile.dart';
class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
    int currentIndex = 0;
     int _activepageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentIndex == 0 ? const PostScreen() : const Profile(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){
        //      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PostForm(
        //        title: 'Add new post',
        //      )));
        //   },
        //   child:const  Icon(Icons.add),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // bottomNavigationBar: BottomAppBar(
        //   notchMargin: 5,
        //   elevation: 10,
        //   clipBehavior: Clip.antiAlias,
        //   shape: const CircularNotchedRectangle(),
        //   child: BottomNavigationBar(
        //     items: const [
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.home),
        //         label: ''
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.person),
        //         label: ''
        //       )
        //     ],
        //     currentIndex: currentIndex,
        //     onTap: (val) {
        //       setState(() {
        //         currentIndex = val;
        //       });
        //     },
        //   ),
        // ), 
    );
  }
}