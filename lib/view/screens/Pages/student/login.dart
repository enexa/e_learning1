// ignore_for_file: constant_identifier_names, use_build_context_synchronously, non_constant_identifier_names, library_private_types_in_public_api


import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants.dart';
import '../../../../controller/service/use_service.dart';
import '../../../../models/api_response.dart';
import '../../../../models/user.dart';

import '../../colors.dart';
import '../teacher/login_teacher.dart';
import 'home.dart';
import 'register.dart';


const Color Active = Color.fromARGB(255, 197, 190, 190);
const Color Inactive = Color.fromARGB(255, 23, 22, 22);
final fields = [
    "IS",
    "CS",
    "SW",
    "IT",
    
  ];

enum UserType { Teacher, Student }

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
   TextEditingController txtfield=TextEditingController();
  TextEditingController txtPassword = TextEditingController();
     TextEditingController departmentController = TextEditingController();
  bool loading = false;
  
  var fields=[
    "IS",
    "CS",
    "SW",
    "IT",
  ];
  
  String? value;

  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text,departmentController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('${response.error}')));
      Get.snackbar("Error", "${response.error}",
    
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.red,
    icon: const Icon(Icons.error,color: Colors.red,),
    
    

    );
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Homewillbe()),
        (route) => false);
  }

  @override
  void initState() {
  
    super.initState();
    visible();
  }

  void visible() {
    setState(() {
      Teachearcolor = Active;
      Studentcolor = Inactive;
    });
  }

  Color Teachearcolor = Inactive;
  Color Studentcolor = Inactive;
  void updatecolor(UserType selected) {
    if (selected == UserType.Teacher) {
      if (Teachearcolor == Inactive) {
        Teachearcolor = Active;
        Studentcolor = Inactive;
      } else {
        Teachearcolor = Inactive;
        Studentcolor = Active;
      }
    } else if (selected == UserType.Student) {
      if (Studentcolor == Inactive) {
        Studentcolor = Active;
        Teachearcolor = Inactive;
      } else {
        Studentcolor = Inactive;
        Teachearcolor = Active;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
        child: Hero(
            tag: 'login',
          child: Scaffold(
            body: Form(
              key: formkey,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 120),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                       Get.to(const Teacher_Login());   
                          setState(() {
                            updatecolor(UserType.Teacher);
                          });
                        },
                        
                        
                        child:Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Teachearcolor,
                                  width: 4,
                                  style: BorderStyle.solid)),
                          height: 200,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                            const   Icon(
                                size: 70,
                                FontAwesomeIcons.book,
                                color: Colors.blue,
                              ),
                              const  SizedBox(height: 12,),
                              Text('Teacher',style: titlestyle,),
                            ],
                          ),
                        ),
                      ),),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              updatecolor(UserType.Student);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Studentcolor,
                                    width: 4,
                                    style: BorderStyle.solid)),
                            height: 200,
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                             const    Icon(
                                  size: 70,
                                  FontAwesomeIcons.graduationCap,
                                  color: Colors.blue,
                                ),
                               const  SizedBox(height: 12,),
                                Text('Student',style: titlestyle,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: txtEmail,
                        validator: (val) =>
                            val!.isEmpty ? 'Invalid email address' : null,
                        decoration: kInputDecoration('Email')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: txtPassword,
                      obscureText: true,
                      validator: (val) =>
                          val!.length < 6 ? 'Required at least 6 chars' : null,
                      decoration: kInputDecoration('Password')),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                   
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: Colors.black,
                           
                            style: BorderStyle.solid)),
                    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        items: fields.map((String department) {
          return DropdownMenuItem<String>(
            value: department,
            child: Text(department),
          );
        }).toList(),
        onChanged: (String? selectedDepartment) {
          setState(() {
            value= selectedDepartment;
            departmentController.text = selectedDepartment!;
          });
        },
        hint: Text('Select Department'),
      ),
    )
                    ),
                 
        
                  const SizedBox(
                    height: 10,
                  ),
                  loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : kTextButton('Login', () {
                        validateDepartment();
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                              _loginUser();
                            });
                          }
                        }),
                 const  SizedBox(
                    height: 10,
                  ),
                  kLoginRegisterHint('Dont have an acount? ', 'Register', () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const Register()),
                        (route) => false);
                  })
                ],
              ),
            ),
          ),
        ),
    
    );
  }

  DropdownMenuItem<String>   buildMenuItem(String item) => DropdownMenuItem<String>(value: item, child: Text(item),);
  
  void validateDepartment() {
     if (value == null) {
    Get.snackbar("Error", "Please select a department",
    
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.red,
    icon: const Icon(Icons.error,color: Colors.red,),);
  
  } else {
  print('okay');
  }
  }}
 


