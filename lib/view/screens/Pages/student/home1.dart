// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controller/schedule_task.dart';
import '../../../../models/schedule.dart';
import '../../../../models/utils/data.dart';
import '../../colors.dart';

import '../../widget/courses.dart';
import '../../widget/items.dart';
import '../../widget/notification.dart';
import '../../widget/tasks.dart';

class Try extends StatefulWidget {
  const Try({ Key? key }) : super(key: key);

  @override
  _TryState createState() => _TryState();
}

class _TryState extends State<Try> {
   DateTime _selectedValue = DateTime.now();
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
    return  CustomScrollView(

        slivers: [
          
          
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => buildBody(),
              childCount: 1,
            ),
          )
        ],
      );
    
  }
   _showtask() {
    return Expanded(
      child:Obx(() {
        return ListView.builder(
          itemCount: _titleController.taskList.length,
          itemBuilder: (_,index)  {
            Task task = _titleController.taskList[index];
            if (task.repeat=='Daily') {
           DateTime date=DateFormat.jm().parse(task.startTime.toString());
           var mytime= DateFormat("HH:mm").format(date);
           notifyhelper.scheduledNotification(
            int.parse(mytime.toString().split(':')[0]),
            int.parse(mytime.toString().split(':')[1]),
            task,
           );
           return  AnimationConfiguration.staggeredList(
            position: index, 
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Row(
                  children: [
                 GestureDetector(
                  onTap: () {
                    _showbuttomsheet(context, task);
                  },
                  child: TaskTile( task),
                 )   
                  ],
                ),
              )));
            

        }
        if (task.date==DateFormat.yMd().format(_selectedValue)) {
      return  AnimationConfiguration.staggeredList(
            position: index, 
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Row(
                  children: [
                 GestureDetector(
                  onTap: () {
                    _showbuttomsheet(context, task);
                  },
                  child: TaskTile( task),
                 )   
                  ],
                ),
              )));
        }
        else{
          return Container(
        
          );
        }
       
          },
        );
      })
    );
  }
  _showbuttomsheet(BuildContext context, Task task) {
 Get.bottomSheet(
      Container(
      height: task.iscompleted==1?
              MediaQuery.of(context).size.height*0.24:
                MediaQuery.of(context).size.height*0.32,  
        decoration:  BoxDecoration(
          color: Get.isDarkMode?Colors.grey[800]:Colors.grey[200],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Container(
             height: 6,
              width: 120,
              decoration: BoxDecoration(
                color: Get.isDarkMode?Colors.grey[800]:Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
task.iscompleted==1? Container(): _bottomsheetbutton(
              label: 'Mark as completed',
              color: bluishclr,
              context: context,
              onTap: () {
                _titleController.markTaskCompleted(task.id!);
               
                Get.back();
              },
            ),
            const SizedBox(height: 5),
            _bottomsheetbutton(
              label: 'Delete Task',
              color: redclr,
              context: context,
              onTap: () {
                _titleController.delete(task);
                
                Get.back();
          
              },
            ),
               const SizedBox(height: 5),
            _bottomsheetbutton(
              label: 'Close',
              color: whiteclr,
              context: context,
              isclose: true,
              onTap: () {
                // _titleController.updateTask(task);
                Get.back();
              },
            ),
              const SizedBox(height: 5),
          ],
        ),
      ),
 );

   }
   _bottomsheetbutton({
      required String label,
      required Color color,
      required Function ()?onTap,
      bool isclose = false,
      required BuildContext context,
   }){
return GestureDetector(
onTap: onTap ,
child: Container(
  margin: const EdgeInsets.symmetric(vertical: 4),
  height: 50,
  width: MediaQuery.of(context).size.width*0.9,

  decoration: BoxDecoration(
   
    borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: isclose==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[400]!:color,
        width: 1,
      ),
    color: isclose?Colors.transparent:color,
  ),
  child: Center(
    child: Text(label,style: isclose?titlestyle:
    titlestyle.copyWith(color: Colors.white),),
  ),
)
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
                  child: Text("Featured", style: TextStyle(color:   Get.isDarkMode?kcolor:kcoloricon, fontWeight: FontWeight.w600, fontSize: 24,)),
                ),
                getFeature(),
              const   SizedBox(height: 15,),
                Container(
                  margin:const  EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text("Recommended", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Get.isDarkMode?kcolor:kcoloricon,),),
                      Text("See all", style: TextStyle(fontSize: 14,   color:Get.isDarkMode?kcolor:kcoloricon,),),
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



