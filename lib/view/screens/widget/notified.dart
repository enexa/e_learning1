// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../colors.dart';


class Notifypage extends StatelessWidget {
  final String ?label;
  const Notifypage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
       foregroundColor:Get.isDarkMode?Colors.white:darkgreyclr,
          title:Text( this.label.toString().split("|")[0],style: headingstyle,),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios_new , size: 20,
            color: Get.isDarkMode?Colors.white:Colors.black,)),
          backgroundColor: context.theme.backgroundColor,
      ),
      body: Center(
        child: Container(
          height:400 ,
          width: 300,
          decoration: BoxDecoration(
            color: Get.isDarkMode?Colors.white:Colors.grey[400],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            
            child: Text(
              this.label.toString().split("|")[1],
              style: TextStyle(
                color: Get.isDarkMode?Colors.black:Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),),
    );
  
  }
}