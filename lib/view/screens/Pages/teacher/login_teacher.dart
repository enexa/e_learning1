// ignore_for_file: constant_identifier_names, use_build_context_synchronously, non_constant_identifier_names, library_private_types_in_public_api, camel_case_types

import 'package:e_learning/controller/service/use_service.dart';
import 'package:e_learning/view/screens/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../../widget/constants.dart';

import '../../../../models/api_response.dart';
import '../../../../models/user.dart';


import '../student/login.dart';
import 'home_teacher.dart';


const Color Active = Color.fromARGB(255, 197, 190, 190);
const Color Inactive = Color.fromARGB(255, 23, 22, 22);

enum UserType { Teacher, Student }

class Teacher_Login extends StatefulWidget {
  const Teacher_Login({super.key});

  @override
  _Teacher_LoginState createState() => _Teacher_LoginState();
}

class _Teacher_LoginState extends State<Teacher_Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtteacherEmail = TextEditingController();
  TextEditingController txtteacherPassword = TextEditingController();
TextEditingController department  = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await login(txtteacherEmail.text, txtteacherPassword.text,department.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false);
  }

  @override
  void initState() {
  
    super.initState();
    visible();
  }

  void visible() {
    setState(() {
      Teachearcolor = Inactive;
      Studentcolor = Active;
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
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 100),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: GestureDetector(
                       
                        
                        
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
                             const Icon(
                                size: 70,
                                FontAwesomeIcons.book,
                                color: Colors.blue,
                              ),
                           const   SizedBox(height: 12,),
                              Text('Teacher',style: titlestyle),
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
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                  (route) => false);
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
                              const  Icon(
                                  size: 70,
                                  FontAwesomeIcons.graduationCap,
                                  color: Colors.blue,
                                ),
                                 const   SizedBox(height: 12,),
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
                        controller: txtteacherEmail,
                        validator: (val) =>
                            val!.isEmpty ? 'Invalid email address' : null,
                        decoration: kInputDecoration('Email')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: txtteacherPassword,
                      obscureText: true,
                      validator: (val) =>
                          val!.length < 6 ? 'Required at least 6 chars' : null,
                      decoration: kInputDecoration('Password')),
                  const SizedBox(
                    height: 10,
                  ),
                  loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : kTextButton('Login', () {
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
                 
                ],
              ),
            ),
          ),
        ),
    
    );
  }
}


