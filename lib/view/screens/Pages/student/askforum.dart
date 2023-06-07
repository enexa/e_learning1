// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_build_context_synchronously

import 'dart:io';



import 'package:e_learning/view/screens/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../../../controller/service/forumservice.dart';
import '../../../../models/utils/forum.dart';
import '../../widget/constants.dart';
import '../../../../controller/service/use_service.dart';
import '../../../../models/api_response.dart';
import '../student/login.dart';


class Forum extends StatefulWidget {
  final Forums? forum;
  final String? title;

  const Forum({super.key, 
    this.forum,
    this.title
  });

  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtControllerBody = TextEditingController();
  bool _loading = false;
  

  void _createForum() async {
  
    ApiResponse response = await createforum(_txtControllerBody.text, );

    if(response.error ==  null) {
      // Navigator.of(context).pop();
    }
    else if (response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false)
      });
    }
    else {
      Get.snackbar("Error", "${response.error}",
    
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.red,
    icon: const Icon(Icons.error,color: Colors.red,),
    
    

    );
      setState(() {
        _loading = !_loading;
      });
    }
  }

 // edit post
  void _editForum(int postId) async {
    ApiResponse response = await editforum(postId, _txtControllerBody.text);
    if (response.error == null) {
    //  Navigator.of(context).pop();
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false)
      });
    }
    else {
      Get.snackbar("Error", "${response.error}",
    
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.red,
    icon: const Icon(Icons.error,color: Colors.red,),
    
    

    );
      setState(() {
        _loading = !_loading;
      });
    }
  }

  @override
  void initState() {
    if(widget.forum != null){
      _txtControllerBody.text = widget.forum!.body ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        leading: GestureDetector(
          onTap: ()=>Get.back(),
          child: const Icon(Icons.arrow_back_ios_new)),
          title:  Text('Ask Forum',style: headingstyle(Get.isDarkMode?Colors.white:Colors.black),),
          centerTitle: true,
        
          foregroundColor: Get.isDarkMode?Colors.white:Colors.black
      ),
      
      body: ListView(
        children: [
          widget.forum != null ? const SizedBox() :
          
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _txtControllerBody,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                validator: (val) => val!.isEmpty ? 'Questions is required' : null,
                decoration:const  InputDecoration(
                  hintText: "Questions...",
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black38))
                ),
              ),
            ),
          ),
          Padding(
            padding:const  EdgeInsets.symmetric(horizontal: 8),
            child: kTextButton('Ask', (){
              if (_formKey.currentState!.validate()){
                showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Forum Created Successfully.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
                setState(() {
                  _loading = !_loading;
                  
                });
                if (widget.forum == null) {
                  _createForum();
                } else {
                  _editForum(widget.forum!.id ?? 0);
                }
              }
              _txtControllerBody.text = '';
            }),
          )
        ],
      ),
    );
  }
}