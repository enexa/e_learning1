
// ignore_for_file: library_private_types_in_public_api

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../controller/routes.dart';
import '../../../../controller/service/use_service.dart';


import '../../colors.dart';
import '../../widget/constants.dart';
import '../student/login.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int _activepageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
       
        appBar: AppBar(
            backgroundColor: context.theme.backgroundColor,
          leading: GestureDetector(
            onTap: ()=>Themeservice().switchTheme(),
            child: Icon(
            Get.isDarkMode?Icons.wb_sunny_outlined: Icons.nightlight_round,
             size: 20,
              color:Get.isDarkMode?Colors.white:Colors.black,
                  ),
          ),
          title:  Text('Bahir Dar University',style:headingstyle(Get.isDarkMode?Colors.white:Colors.black)),
          centerTitle: true,
           foregroundColor:Get.isDarkMode?Get.isDarkMode?Colors.white:Colors.black:Get.isDarkMode?Colors.black:Colors.white,
          actions: [
          PopupMenuButton(
           itemBuilder: (context) => [
              PopupMenuItem(
                          value: 'Logout',
                          child:  Text('Logout',style:subtitlestyle(Get.isDarkMode?Colors.white:Colors.black))
                        ),
           ],
            onSelected: (val){
                        if(val == 'Logout'){
                           logout().then((value) => {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false)
              });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
          content: Text(somethingWentWrong)
          ));
                        }
                      },
            child:  Padding(
                        padding: const EdgeInsets.only(right:10),
                        child: Icon(Icons.more_vert, color:Get.isDarkMode?Colors.white:Colors.black,)
                      ),
          )
        ],
        ),
        body:  PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _activepageIndex = index;
          });
        },
        children: [
          navigation[0]['pageName'],
          navigation[1]['pageName'],
          navigation[2]['pageName'],
          navigation[3]['pageName'],
          
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _activepageIndex,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(microseconds: 400), curve: Curves.ease);
        },
        height: 50.0,
        items:  const <Widget>[
        Icon(Icons.home,size: 20,color:blackclr),
        Icon(Icons.add_a_photo,size: 20,color:blackclr),
        Icon(Icons.live_tv_rounded,size: 20,color:blackclr),
         Icon(Icons.person,size: 20,color:blackclr),
      
        
          // Icon(Icons.perm_identity, size: 20),
        ],
        backgroundColor: Colors.blue,
      
      ),
      ),
    );
  }
}


// comment 
// currentIndex == 0 ? const PostScreen() : const Profile(),
//         floatingActionButton: FloatingActionButton(
//           onPressed: (){
//              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PostForm(
//                title: 'Add new post',
//              )));
//           },
//           child:const  Icon(Icons.add),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: BottomAppBar(
//           notchMargin: 5,
//           elevation: 10,
//           clipBehavior: Clip.antiAlias,
//           shape: const CircularNotchedRectangle(),
//           child: BottomNavigationBar(
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: ''
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: ''
//               )
//             ],
//             currentIndex: currentIndex,
//             onTap: (val) {
//               setState(() {
//                 currentIndex = val;
//               });
//             },
//           ),
//         ),