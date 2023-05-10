// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_learning/view/screens/Pages/student/notification.dart';
import 'package:flutter/material.dart';

import 'package:e_learning/controller/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';


import '../../../../controller/service/use_service.dart';
import '../../../../models/api_response.dart';
import '../../../../models/user.dart';



import '../../colors.dart';
import '../../widget/constants.dart';
import 'alert.dart';
import 'help.dart';
import 'login.dart';
class Homewillbe extends StatefulWidget {
  const Homewillbe({super.key});

  @override
  State<Homewillbe> createState() => _HomewillbeState();
}

class _HomewillbeState extends State<Homewillbe> {
  int _activepageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
   User? user;
  bool loading = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
   File? _imageFile;
  final _picker = ImagePicker();
  TextEditingController txtNameController = TextEditingController();
   final _box = GetStorage();
  final _key = 'isDarkMode';

  bool get isDarkMode => _box.read(_key) ?? false;

  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null){
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // get user detail
  void getUser() async {
    ApiResponse response = await getUserDetail();
    if(response.error == null) {
      setState(() {
        user = response.data as User;
        loading = false;
        txtNameController.text = user!.name ?? '';
      });
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false)
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }

  //update profile
  void updateProfile() async {
    ApiResponse response = await updateUser(txtNameController.text, getStringImage(_imageFile));
      setState(() {
        loading = false;
      });
    if(response.error == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.data}')
      ));
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false)
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }
  void mycolor(){
    setState(() {
      Get.changeTheme(ThemeData.dark());
      Get.changeThemeMode(ThemeMode.dark);

      
      
    });
  }
   void switchTheme() {
    setState(() {
      Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    _box.write(_key, !isDarkMode);
    });
   
  }

  @override
  void initState() {
 
    getUser();
    super.initState();
    
  }
  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
    
      child: SafeArea(
          child: Scaffold(
          backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
         
          actions: [
            GestureDetector(
              onTap: () => Get.to( const MyNotification()),
              child:  Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
shape: BoxShape.circle,
color: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:14.0),
                    child: Icon(
                            Icons.notification_important,color: Get.isDarkMode?Colors.white:Colors.black,
                ),
                  ),
                ],
               
              ),
            ),
            PopupMenuButton(
             itemBuilder: (context) => [
                PopupMenuItem(
                            value: 'Logout',
                            child:  Text('Logout',style: titlestyle(Get.isDarkMode?Colors.white:Colors.black),)
                          ),
             ],
              onSelected: (val){
                          if(val == 'Logout'){
                             logout().then((value) => {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false)
                });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(somethingWentWrong)
            ));
                          }
                        },
              child:  Padding(
                          padding: const EdgeInsets.only(right:10),
                          child: Icon(Icons.more_vert, color: Get.isDarkMode?Colors.white:Colors.black,)
                        ),
            )
          ],
          leading: Builder(
            builder: (context) => IconButton(
              icon:  ImageIcon(
              const  AssetImage('assets/menu-bar.png'),
                size: 24,
             color:Get.isDarkMode?Colors.white:Colors.black,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          
          centerTitle: true,
          
          title:  Text(
            'Bahir Dar University',
            style:headingstyle( Get.isDarkMode?Colors.white:Colors.black) ,
          ),
        backgroundColor: context.theme.backgroundColor,
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _activepageIndex = index;
            });
          },
          children: [
            pageDetails[0]['pageName'],
            pageDetails[1]['pageName'],
            pageDetails[2]['pageName'],
            pageDetails[3]['pageName'],
             pageDetails[4]['pageName'],
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
          Icon(Icons.home,size: 20,color: blackclr,),
          Icon(Icons.picture_as_pdf_rounded,size: 20,color: blackclr),
          Icon(Icons.notifications,size: 20,color: blackclr,),
          Icon(Icons.forum,size: 20,color: blackclr,),
          Icon(Icons.person,size: 20,color: blackclr),
          
            // Icon(Icons.perm_identity, size: 20),
          ],
          backgroundColor: Colors.blue,
        ),
        drawer: SafeArea(
          child: Drawer(
            width: 230,
            
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                 UserAccountsDrawerHeader(
                  accountEmail:Text(
                              '${user!.email}',
                              style:  TextStyle(
                                fontWeight: FontWeight.w600,
                                color:Get.isDarkMode?Colors.white:Colors.black,
    
                                fontSize: 17
                              ),
                            ),
                                accountName: Text(
                              '${user!.name}',
                              style:  TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                      color:Get.isDarkMode?Colors.white:Colors.black,
                              ),
                            ),
                  
                  currentAccountPicture: GestureDetector(
                child: Stack(
                  children: [
    
                
                   Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: _imageFile == null ? user!.image != null ? DecorationImage(
                        image: NetworkImage('${user!.image}'),
                        fit: BoxFit.cover
                      ) : null : DecorationImage(
                        image: FileImage(_imageFile ?? File('')),
                        fit: BoxFit.cover
    
                      ),
    
                      color: Colors.grey
                    ),
                  ),
                   Padding(
                    padding:const EdgeInsets.only(top:50.0, left: 20),
                    child: Icon(Icons.camera_alt, color: Get.isDarkMode?Colors.white:Colors.black,
                    size: 30,
                    ),
                  )
                  ],),
                onTap: (){
                  getImage();
                },
              )
                  // otherAccountsPictures: const [],
                ),
                ListTile(
                  title: const Text('home'),
                  leading:  Icon(
                    Icons.home,
                    color:Get.isDarkMode?Colors.white:Colors.black,
                  ),
                  onTap: () =>Get.back(),
                  trailing:  Icon(
                    Icons.arrow_right,
                   color:Get.isDarkMode?Colors.white:Colors.black,
                  ),
                ),
               const  Divider(
                  height: 2,
                  color: Colors.grey,
    
                ),
               
                ListTile(
                  title: const Text('help'),
                  leading:  Icon(
                    Icons.help,
                     color:Get.isDarkMode?Colors.white:Colors.black,
                  ),
                  onTap: ()=>Get.to(const Help()),
                  trailing:  Icon(
                    Icons.arrow_right,
                     color:Get.isDarkMode?Colors.white:Colors.black,
                  ),
                ),
                 const Divider(
                  height: 2,
                  color: Colors.grey,
    
                ),
                ListTile(
                  title:  Text(Get.isDarkMode?'Light Mode':'Dark Mode'),
                  leading: Icon(
            Get.isDarkMode?Icons.wb_sunny_outlined: Icons.nightlight_round,
             size: 20,
              color:Get.isDarkMode?Colors.white:Colors.black,
          ),
                  onTap: (){
                    setState(() {
                   Themeservice().switchTheme();
    
                   
                    },);
    
                  } ,
                  trailing:  Icon(
                    Icons.arrow_right,
                     color:Get.isDarkMode?Colors.white:Colors.black,
                  ),
                ),
                 const Divider(
                  height: 2,
                  color: Colors.grey,
    
                ),
              
              ],
            ),
          ),
        ),
      )),
    );
  }
}
