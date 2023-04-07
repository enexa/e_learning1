// ignore_for_file: override_on_non_overriding_member



import 'package:get/get.dart';

import '../models/local_db.dart';
import '../models/schedule.dart';


class TaskController extends GetxController{
  @override
  void onready(){
    getTasks();
    super.onReady();
  }
  var taskList=<Task>[].obs;
  Future<int>addTask({  Task?task})async{
    return await DBHelper.insert(task);
  }
  void getTasks() async{
   List<Map<String,dynamic>>tasks=await DBHelper.query();
    taskList.assignAll(tasks.map((data)=>  Task.fromJSON(data)).toList());
  }
  void delete(Task task){
 DBHelper.delete(task);
  getTasks();

  }
 void markTaskCompleted(int id) async {
   await DBHelper.update(id);
   getTasks();
  }
}