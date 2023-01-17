
// ignore_for_file: library_private_types_in_public_api

import 'package:e_learning/view/screens/Pages/teacher/post.dart';
import 'package:e_learning/view/screens/Pages/teacher/post_screen.dart';
import 'package:flutter/material.dart';

import '../../../../controller/service/use_service.dart';
import '../../login.dart';
import '../../student_profile.dart';
import 'profile.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: (){
              logout().then((value) => {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false)
              });
            },
          )
        ],
      ),
      body: currentIndex == 0 ? const PostScreen() : const Profile(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PostForm(
             title: 'Add new post',
           )));
        },
        child:const  Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: ''
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: ''
            )
          ],
          currentIndex: currentIndex,
          onTap: (val) {
            setState(() {
              currentIndex = val;
            });
          },
        ),
      ),
    );
  }
}