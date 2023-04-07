// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_learning/view/screens/Pages/student/student_profile.dart';

import 'package:flutter/material.dart';

import 'package:e_learning/controller/routes.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants.dart';
import '../../../../controller/service/use_service.dart';
import '../../../../models/api_response.dart';
import '../../../../models/user.dart';



import '../../colors.dart';
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

  @override
  void initState() {
 
    getUser();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          
           backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        foregroundColor: kcolor,
        actions: [
          PopupMenuButton(
           itemBuilder: (context) => [
             const PopupMenuItem(
                          value: 'Logout',
                          child:  Text('Logout')
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
                        child: Icon(Icons.more_vert, color:  Get.isDarkMode?kcolor:kcoloricon,)
                      ),
          )
        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon:  ImageIcon(
            const  AssetImage('assets/menu-bar.png'),
              size: 24,
           color:Get.isDarkMode?kcolor:kcoloricon,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        
        centerTitle: true,
        title:  Text(
          'Bahir Dar University',
          style:headingstyle ,
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
        items:  <Widget>[
        Icon(Icons.home,size: 20,color: kcoloricon,),
        Icon(Icons.search,size: 20,color: kcoloricon),
        Icon(Icons.notifications,size: 20,color: kcoloricon,),
        Icon(Icons.forum,size: 20,color: kcoloricon,),
        Icon(Icons.person,size: 20,color: kcoloricon),
        
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
                              color:kcolor,

                              fontSize: 17
                            ),
                          ),
                              accountName: Text(
                            '${user!.name}',
                            style:  TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                                    color:kcolor,
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
                  child: Icon(Icons.camera_alt, color: kcolor,
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
                  color:Get.isDarkMode?kcolor:kcoloricon,
                ),
                onTap: () =>Get.back(),
                trailing:  Icon(
                  Icons.arrow_right,
                 color:Get.isDarkMode?kcolor:kcoloricon,
                ),
              ),
             const  Divider(
                height: 2,
                color: Colors.grey,

              ),
              ListTile(
                title: const Text('profile'),
                leading:  Icon(
                  Icons.person,
                color:Get.isDarkMode?kcolor:kcoloricon,
                ),
                onTap: () =>Get.to(const Student_Profile()),
                trailing:  Icon(
                  Icons.arrow_right,
                 color:Get.isDarkMode?kcolor:kcoloricon,
                ),
              ),
             const   Divider(
                height: 2,
                color: Colors.grey,

              ),
              ListTile(
                title: const Text('help'),
                leading:  Icon(
                  Icons.help,
                   color:Get.isDarkMode?kcolor:kcoloricon,
                ),
                onTap: ()=>Get.to(const Help()),
                trailing:  Icon(
                  Icons.arrow_right,
                   color:Get.isDarkMode?kcolor:kcoloricon,
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
            color:Get.isDarkMode?kcolor:kcoloricon,
        ),
                onTap: ()=> Themeservice().switchTheme(),
                trailing:  Icon(
                  Icons.arrow_right,
                   color:Get.isDarkMode?kcolor:kcoloricon,
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
    ));
  }
}
