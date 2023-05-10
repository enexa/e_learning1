// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_build_context_synchronously

import 'dart:io';



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../widget/constants.dart';
import '../../../../controller/service/post_service.dart';
import '../../../../controller/service/use_service.dart';
import '../../../../models/api_response.dart';
import '../../../../models/post.dart';
import '../student/login.dart';


class PostForm extends StatefulWidget {
  final announcements? post;
  final String? title;

  const PostForm({super.key, 
    this.post,
    this.title
  });

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtControllerBody = TextEditingController();
  bool _loading = false;
   File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null){
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _createPost() async {
    String? image = _imageFile ==  null ? null : getStringImage(_imageFile);
    ApiResponse response = await createPost(_txtControllerBody.text, image);

    if(response.error ==  null) {
      Navigator.of(context).pop();
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
  void _editPost(int postId) async {
    ApiResponse response = await editPost(postId, _txtControllerBody.text);
    if (response.error == null) {
     Navigator.of(context).pop();
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
    if(widget.post != null){
      _txtControllerBody.text = widget.post!.body ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:_loading ? const Center(child: CircularProgressIndicator(),) :  ListView(
        children: [
          widget.post != null ? const SizedBox() :
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              image: _imageFile == null ? null : DecorationImage(
                image: FileImage(_imageFile ?? File('')),
                fit: BoxFit.cover
              )
            ),
            
            child: Center(
              child:
                  TextButton(
                    style: ButtonStyle(shape:       
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.blue)
                        )
                      )
                    ),
                    onPressed: (){
                      getImage();
                    }, child: const Text('upload Image',style:TextStyle(fontSize: 15),),
                  ),
                 
               
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _txtControllerBody,
                keyboardType: TextInputType.multiline,
                maxLines: 9,
                validator: (val) => val!.isEmpty ? 'Post body is required' : null,
                decoration:const  InputDecoration(
                  hintText: "Post body...",
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black38))
                ),
              ),
            ),
          ),
          Padding(
            padding:const  EdgeInsets.symmetric(horizontal: 8),
            child: kTextButton('Post', (){
              if (_formKey.currentState!.validate()){
                setState(() {
                  _loading = !_loading;
                });
                if (widget.post == null) {
                  _createPost();
                } else {
                  _editPost(widget.post!.id ?? 0);
                }
              }
            }),
          )
        ],
      ),
    );
  }
}