

// ignore_for_file: unused_field

import 'package:date_picker_timeline/date_picker_timeline.dart';


import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../controller/schedule_task.dart';
import '../../../../models/schedule.dart';
import '../../colors.dart';
import '../../widget/button.dart';
import '../../widget/notification.dart';
import '../../widget/tasks.dart';


class MyNotification extends StatefulWidget {
  const MyNotification({super.key});

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
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
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
         backgroundColor: context.theme.backgroundColor,
        leading: GestureDetector(
          onTap: () => Get.back,
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        title:const  Text('Notifications'),
      ),
          backgroundColor: context.theme.backgroundColor,
          body:Column(
            children: [
             _addTaskBar(),
             _addTime(),
              const SizedBox(height: 10,),
             _showtask(),
            ],
          )
      ),
    );
  }
  _addTime(){
    return Container(
              margin: const EdgeInsets.only(left: 20,top:20),
              child: DatePicker(
                DateTime.now(),
                width: 80,
                height: 100,
                // controller: _controller,
                initialSelectedDate: DateTime.now(),
                selectionColor: bluishclr,
                selectedTextColor: Colors.white,
               dateTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color:  Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),),
                dayTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color:  Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),),
                monthTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color:  Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),),
            
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedValue = date;
                  });
                },
              ),
              );
  }
  _addTaskBar(){
    return  Container(
                margin: const EdgeInsets.only(left: 20,right: 20,top:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [                    
                  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text( DateFormat.yMMMMd().format(DateTime.now()),
                        style: subheading(kcolor),),
                        Text('Today',style: headingstyle(kcolor),),
                          ],
                      ),
                
                      MyButton(label: '+ Add Task', onTap:(){
                       
                        _titleController.getTasks();
                          }),
                  ],
                ),
              );
  }
  _appbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      title:  Text('enex studio',style: subheading(kcolor),),
      centerTitle: true,
     foregroundColor:Get.isDarkMode?Colors.white:darkgreyclr,
      leading: GestureDetector(
        onTap: () {
          Themeservice().switchTheme();

       notifyhelper. scheduledNotification(

       );

        },
        child:  Icon(
         Get.isDarkMode?Icons.wb_sunny_outlined: Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode?Colors.white:Colors.black,
        ),
      ),
      actions: const[
         CircleAvatar(
          backgroundImage:AssetImage('assets/chan.jpg')),
        
         SizedBox(width:  28,)
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
    child: Text(label,style: titlestyle(kcolor)
    ),
  ),
)
);


   }
}
