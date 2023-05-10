// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:e_learning/models/api_response.dart';
import 'package:e_learning/models/user.dart';
import 'package:e_learning/controller/service/use_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:image_picker/image_picker.dart';


import '../../widget/constants.dart';
import 'changepassword.dart';
import 'login.dart';

// ignore: camel_case_types
class Student_Profile extends StatefulWidget {
  const Student_Profile({super.key});

  @override
  _Student_ProfileState createState() => _Student_ProfileState();
}

// ignore: camel_case_types
class _Student_ProfileState extends State<Student_Profile> {
  User? user;
  bool loading = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _imageFile;
  final _picker = ImagePicker();
  TextEditingController txtNameController = TextEditingController();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // get user detail
  void getUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
        loading = false;
        txtNameController.text = user!.name ?? '';
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  //update profile
  void updateProfile() async {
    ApiResponse response =
        await updateUser(txtNameController.text, getStringImage(_imageFile));
    setState(() {
      loading = false;
    });
    if (response.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.data}')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
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
      
        body: 
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
                    child: ListView(
                      children: [
                        Center(
                            child: GestureDetector(
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                image: _imageFile == null
                                    ? user!.image != null
                                        ? DecorationImage(
                                            image: NetworkImage('${user!.image}'),
                                            fit: BoxFit.cover)
                                        : null
                                    : DecorationImage(
                                        image: FileImage(_imageFile ?? File('')),
                                        fit: BoxFit.cover),
                                color: Colors.grey),
                          ),
                          onTap: () {
                            getImage();
                          },
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: formKey,
                          child: TextFormField(
                            decoration: kInputDecoration('Name'),
                            controller: txtNameController,
                            validator: (val) => val!.isEmpty ? 'Invalid Name' : null,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        kTextButton('Update', () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            updateProfile();
                          }
                        }),
                        kTextButton('change password',(){
    Get.to(const ChangePassword());
                        }),
                     
                        
                      ],
                    ),
                  ),
          
        
      ),
    );
  }
}
