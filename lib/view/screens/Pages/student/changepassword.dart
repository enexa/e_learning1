

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../colors.dart';
import '../../widget/constants.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    
    
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;
    
    final response = await http.post(Uri.parse(changepasswordURL), body: {
      'current_password': currentPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    });

    if (response.statusCode == 200) {
      // Password change successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully')),
      );
      Navigator.pop(context);
    } else {
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password change failed')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
         backgroundColor: context.theme.backgroundColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child:  Icon(Icons.arrow_back_ios_new,color: Get.isDarkMode?Colors.white:Colors.black,),
        ),
        title:  Text('Change Password',style:headingstyle(Get.isDarkMode?Colors.white:Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                 padding: const EdgeInsets.only(top: 15.0),
                child: TextFormField(
                  controller: _currentPasswordController,
                  obscureText: true,
                   decoration: kInputDecoration('Current Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your current password.';
                    }
                    return null;
                  },
                ),
              ),
                const SizedBox(
                    height: 10,
                  ),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: kInputDecoration('New Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a new password.';
                  }
                  if (value.length < 6) {
                    return 'Your password must be at least 6 characters long.';
                  }
                  return null;
                },
              ),
                const SizedBox(
                    height: 10,
                  ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: kInputDecoration('Confirm Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your new password.';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Your passwords do not match.';
                  }
                  return null;
                },
              ),
                const SizedBox(
                    height: 10,
                  ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}