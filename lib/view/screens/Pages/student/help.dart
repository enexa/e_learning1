


import 'package:e_learning/view/screens/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        leading: GestureDetector(
          onTap: ()=>Get.back(),
          child: const Icon(Icons.arrow_back_ios_new)),
          title:  Text('Ask Forum',style: headingstyle(Get.isDarkMode?Colors.white:Colors.black),),
          centerTitle: true,
        
          foregroundColor: Get.isDarkMode?Colors.white:Colors.black
      ),
    ));
  }
}
