// ignore_for_file: prefer_const_declarations, avoid_print

import 'package:e_learning/models/schedule.dart';

import 'package:sqflite/sqflite.dart';

class DBHelper{
  static Database?_db;
  static final String dbName="elearning.db";
  static final String tableName="task";
  static final String id="id";
  static final int version=1;
  static Future<void>initDb()async{
    if(_db!=null){
     return;
    }
    try{
      String path=await getDatabasesPath()+dbName;
      _db=await openDatabase(path,version: version,
      onCreate: (db,version){
        return db.execute(
      "CREATE TABLE $tableName("
       "$id INTEGER PRIMARY KEY AUTOINCREMENT,"
       "title STRING,note TEXT, date STRING,"
       "startTime STRING, endTime STRING,"
       "remind INTEGER, repeat STRING,"
       "color INTEGER,"
       "iscompleted INTEGER)"
        );
      });

      }catch(e){
      print(e);
      }
  }
  static Future<int>insert(Task?task)async{
    return await _db?.insert(tableName, task?.toJson()??{})??1;
  }
  static Future<List<Map<String,dynamic>>>query()async{
    return await _db!.query(tableName);

  }
  static delete(Task task)async{
return await _db!.delete(tableName,where: "id=?",whereArgs: [task.id]);
  }
  static update(int id)async{
  return await  _db!.rawUpdate('''
    UPDATE task
    SET iscompleted=?
    WHERE id=?
''',[1,id]);

  }}
