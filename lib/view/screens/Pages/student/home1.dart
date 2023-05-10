// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, unused_element, unused_field

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../controller/schedule_task.dart';

import '../../../../models/utils/data.dart';
import '../../colors.dart';

import '../../widget/courses.dart';
import '../../widget/items.dart';
import '../../widget/notification.dart';


class Try extends StatefulWidget {
  const Try({ Key? key }) : super(key: key);

  @override
  _TryState createState() => _TryState();
}

class _TryState extends State<Try> {
   final DateTime _selectedValue = DateTime.now();
  final _titleController = Get.put(TaskController());
  // ignore: prefer_typing_uninitialized_variables
  var notifyhelper;
  @override
  void initState() {
    super.initState();
    notifyhelper=Notify();
   notifyhelper. initializeNotification();
   _titleController.getTasks();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: context.theme.backgroundColor,
      body: CustomScrollView(
    
          slivers: [
            
            
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => buildBody(),
                childCount: 1,
              ),
            )
          ],
        ),
    );
    
  }
  


  buildBody(){
    return
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
            
               const  SizedBox(height: 15,),
                 Padding(
                  padding: const  EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Text("Courses", style: subheading(Get.isDarkMode?Colors.white:Colors.black)),
                ),
                getFeature(),
              const   SizedBox(height: 15,),
                Container(
                  margin:const  EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text("Recent", style: subheading(Get.isDarkMode?Colors.white:Colors.black)),
                      Text("See all", style: subheading(Get.isDarkMode?Colors.white:Colors.black)),
                    ],
                  ),
                ),
                getRecommend(),
              ]
          ),
        ),
      );
  }
  int selectedCollection = 0;
  

  getFeature(){
    return 
      CarouselSlider(

        options: CarouselOptions(
          
          height: 290,
          enlargeCenterPage: true,
          disableCenter: true,
          viewportFraction: .75,
        ),
        items: List.generate(features.length, 
          (index) => FeatureItem(
            onTap: (){
              
            },
            data: features[index]
          )
        )
      );
  }

  getRecommend(){
    return
    SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(recommends.length, (index) => 
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: RecommendItem(
                data: recommends[index],
                onTap: (){
                  
                },
              )
            ) 
          )
        ),
      );
  }

}



