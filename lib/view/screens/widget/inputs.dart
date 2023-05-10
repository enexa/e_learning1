// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';




class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget?widget;

  const MyInputField({super.key, required this.title, required this.hint, this.controller, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
    

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    Text(title,
    style: titlestyle(Get.isDarkMode?Colors.white:Colors.black),
    ),
    Container(

      height: 45  ,
     
      padding: const EdgeInsets.only(left: 14) ,
    
      decoration: BoxDecoration(
        border: Border.all(
          color:Colors.grey,
          width: 1.0
        ),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          Expanded(child: 
          TextFormField(

            readOnly: false,
            autofocus: false,
            cursorColor:Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
            controller: controller,
            style: subtitlestyle(Get.isDarkMode?Colors.white:Colors.black),
            decoration: InputDecoration(
                enabled: widget==null?true:false,
              hintText: hint,
              hintStyle: subtitlestyle(Get.isDarkMode?Colors.white:Colors.black),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 20, ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: context.theme.backgroundColor,
                  width: 0,
                  ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: context.theme.backgroundColor,
                  width: 0,
                  ),
              ), 
              )
            ),    
          ),
          widget==null?Container():Container(child: widget,)
        ],
      ),
    )

        ],
      ),
    );
  }
}