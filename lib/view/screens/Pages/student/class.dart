

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controller/schedule_task.dart';
import '../../../../models/schedule.dart';
import '../../colors.dart';
import '../../widget/notification.dart';
import '../../widget/tasks.dart';

class Class extends StatefulWidget {
  const Class({super.key});

  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
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
    return Column(
children: [
  _showtask(),
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
}