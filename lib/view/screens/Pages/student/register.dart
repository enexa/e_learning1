// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:e_learning/models/api_response.dart';
import 'package:e_learning/models/user.dart';
import 'package:e_learning/controller/service/use_service.dart';
import 'package:e_learning/view/screens/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../../widget/constants.dart';
import 'home.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      passwordConfirmController = TextEditingController();
      TextEditingController departmentController = TextEditingController();

  
  var fields=[
    "IS",
    "CS",
    "SW",
    "IT",
  ];
  
  String? value;

  void _registerUser() async {
    ApiResponse response = await register(
        nameController.text, emailController.text, passwordController.text,departmentController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = !loading;
      });
      // ignore: use_build_context_synchronously
     Get.snackbar("Error", "${response.error}",
    
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.red,
    icon: const Icon(Icons.error,color: Colors.red,),
    
    

    );
    }
  }

  // Save and redirect to home
  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Homewillbe()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar( 
           backgroundColor: context.theme.backgroundColor,
        leading: GestureDetector(
          onTap: ()=>Get.to(const Login()),
          child: const Icon(Icons.arrow_back_ios_new)),
          title:  Text('Bahir Dar University',style: headingstyle(Get.isDarkMode?Colors.white:Colors.black),),
          centerTitle: true,
        
          foregroundColor: Get.isDarkMode?Colors.white:Colors.black
        ), 
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            children: [
              TextFormField(
                  controller: nameController,
                  validator: (val) => val!.isEmpty ? 'Invalid name' : null,
                  decoration: kInputDecoration('Name')),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) =>
                      val!.isEmpty ? 'Invalid email address' : null,
                  decoration: kInputDecoration('Email')),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (val) =>
                      val!.length < 6 ? 'Required at least 6 chars' : null,
                  decoration: kInputDecoration('Password')),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: passwordConfirmController,
                  obscureText: true,
                  validator: (val) => val != passwordController.text
                      ? 'Confirm password does not match'
                      : null,
                  decoration: kInputDecoration('Confirm password')),
                   Container(
                    margin: const EdgeInsets.only(top:10),
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
                     ),
                   ),
              const SizedBox(
                height: 10,
              ),
              loading
                  ? const Center(child: CircularProgressIndicator())
                  : kTextButton(
                      'Register',
                      () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            loading = !loading;
                            _registerUser();
                          });
                        }
                      },
                    ),
              const SizedBox(
                height: 10,
              ),
              kLoginRegisterHint('Already have an account? ', 'Login', () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false);
              })
            ],
          ),
        ),
      ),
    );
  }
}
