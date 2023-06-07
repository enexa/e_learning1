// ignore_for_file: prefer_final_fields, use_build_context_synchronously, avoid_print, unused_element

import 'package:e_learning/view/screens/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../controller/schedule_task.dart';
import '../../../../models/schedule.dart';
import '../../widget/button.dart';
import '../../widget/inputs.dart';
import 'livestream.dart';



class MyStream extends StatefulWidget { 
  const MyStream({super.key});

  @override
  State<MyStream> createState() => _MyStreamState();
}

class _MyStreamState extends State<MyStream> {
  final TaskController _taskController=Get.put(TaskController());
  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _noteController=TextEditingController();  
 bool isLoading =true;

  DateTime _selectedDate=DateTime.now();
  String _endTime="9:30 pm";
  String _startTime=DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedremind=5;
  List<int>remindList=[
    5,
    10,
    15,
    20
  ];
  String _selectedRepeat="None";
  List<String>repeatList=[
    "None",
     "Daily",
      "Weekly",
        "Monthly",
   
  ];
  int _selectedcolor=0;
  Widget buildShimmeringContainer(double height, double width) {
    return Shimmer.fromColors(
          period: const Duration(milliseconds: 800),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }
   Widget BuildShimmer() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              buildShimmeringContainer(70, 70),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildShimmeringContainer(12, double.infinity),
                    const SizedBox(height: 5),
                    buildShimmeringContainer(12, 150),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
     
        body: isLoading?BuildShimmers():
        Container(
          margin:const  EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("Schedule Live stream ",style: headingstyle(Get.isDarkMode?Colors.white:Colors.black),)),
                MyInputField(title: 'Title', hint: 'enter your title',controller: _titleController,),
                 MyInputField(title: 'note', hint: 'enter your note',controller: _noteController,),
                  MyInputField(title: 'Date', hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(onPressed: () => _getdatefromuser(), icon:  Icon(Icons.calendar_today_outlined,color: Get.isDarkMode? Colors.white:Colors.grey[700],),),
                  
                  ),
                  Row(
                    children: [
                    Expanded(child: 
                    MyInputField(title: 'Start time', hint: _startTime,
                    widget: IconButton(onPressed: (() => _getusertime(isStarttime: true)), icon: Icon(Icons.access_time_filled_rounded,color: Get.isDarkMode?Colors.white:Colors.grey[500],)),))  ,
                    const SizedBox(width: 12,),
                      Expanded(child:MyInputField(title: 'end time', hint: _endTime,
                    widget: IconButton(onPressed: (() => _getusertime(isStarttime: false)), icon: Icon(Icons.access_time_filled_rounded,color: Get.isDarkMode?Colors.white:Colors.grey[500],)),))  
                    ],
                  ),
                 
                    const SizedBox(height: 18,),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // _getColor() ,
                          MyButton(label: "\tSchedule \nlive stream", onTap: (){

                            _validate();
                            _clear();
                            Get.snackbar("Success", "Your live stream has been scheduled",
    
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white,
                              colorText: Colors.green,
                              icon: const Icon(Icons.access_time_filled_rounded,color: Colors.white30,),
    
    

    );

                            }
                         
                          ),
                           MyButton(label: "\t\tStart \nlive stream", onTap: ()=>Get.to(const Livestream()) )
                        ],
                      ),
                      const SizedBox(height: 20,),
    
    
              ],
            ),
          ),
        ),
      ),
    );
  }
  _validate(){
   if(_titleController.text.isEmpty&&_noteController.text.isEmpty){
   
   
   }
   else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
    Get.snackbar("Error", "Please fill all the fields",
    
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.red,
    icon: const Icon(Icons.error,color: Colors.red,),
    
    

    );
   }
   else{
     Get.back();
    setState(() {
       _addTaskToDb();
    });
   }

   }

  _getColor(){
    return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Color',style: titlestyle(Get.isDarkMode?Colors.white:Colors.black),),
                              const SizedBox(height: 8.0,),
                              Wrap(
                                children: 
                                  List<Widget>.generate(3, (int index) =>   GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _selectedcolor=index;
                                      });
                                     
                                    },
                                    child: Padding(
                                      padding:  const  EdgeInsets.only(right:8.0),
                                      child:  CircleAvatar(
                                        radius: 14,
                                        backgroundColor:  index==0?blueclr:index==1?Colors.pink:Colors.yellow,
                                        child: _selectedcolor==index?   const Icon(Icons.done,color: Colors.white,size: 18,):Container(),
                                      ),
                                    ),
                                  ))
                                
                              )
                            ],
                          );
  }
  _getusertime({required bool isStarttime}) async {
   var pickedtime= await _showtimepicker();
   String formatedTime=pickedtime.format(context);
   if(pickedtime==null){
    print("time cancelled");
   }
  else if(isStarttime==true){
    setState(() {
      _startTime=formatedTime;
    });
    

  }
  else if(isStarttime==false){
    setState(() {
        _endTime=formatedTime;
    });
  

  }
  
  }
  _showtimepicker(){
     return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
    context: context,
     initialTime:  TimeOfDay(
      hour:int.parse(_startTime.split(":")[0]) , 
      minute:int.parse(_startTime.split(":")[1].split(" ")[0]))); 
  }
_getdatefromuser()async{
  DateTime ?pickerDate=await showDatePicker(
    context: context,
     initialDate: DateTime.now(),
      firstDate: DateTime(2015), lastDate: DateTime(2121));
      if(pickerDate!=null){
        setState(() {
          _selectedDate=pickerDate;
        });
        
      }else{
        print('something went wrong'); 
      }
}
 
  
   _addTaskToDb() async {
    await _taskController.addTask(
   task: Task(
      note: _noteController.text,
      title: _titleController.text,
      color: _selectedcolor,
      date: DateFormat.yMd().format(_selectedDate),
      remind: _selectedremind,
      repeat: _selectedRepeat,
      startTime: _startTime,
      endTime: _endTime,
      iscompleted: 0,

    ));

    
}

   _clear() {
    _titleController.clear();
    _noteController.clear();
    setState(() {
      _selectedcolor=0;
      _selectedDate=DateTime.now();
      _selectedremind=0;
      _selectedRepeat='Never';
      _startTime='00:00 AM';
      _endTime='00:00 AM';
    });
   }}
   
   class BuildShimmers extends StatelessWidget{
     @override
     Widget build(BuildContext context) {
     return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              buildShimmeringContainer(70, 70),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildShimmeringContainer(12, double.infinity),
                    const SizedBox(height: 5),
                    buildShimmeringContainer(12, 150),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
     }
     
      buildShimmeringContainer(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }

  
   }