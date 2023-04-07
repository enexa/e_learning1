


import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'myonline.dart';




class Livestream extends StatefulWidget {
  const Livestream({super.key});

  @override
  State<Livestream> createState() => _LivestreamState();
}
  
class _LivestreamState extends State<Livestream> {
  final TextEditingController _studentusername = TextEditingController();
  final TextEditingController _channelcode = TextEditingController();
  late int uid;
  @override
  void initState() {
  
    super.initState();
    getuseruid();
  }
  Future<void> getuseruid() async{
    // uid = await _engine.getCallId();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? storeduid = prefs.getInt('uid');
    if(storeduid!=null){
      setState(() {
        uid = storeduid;
      });
    }
    else{
     int time = DateTime.now().millisecondsSinceEpoch;
     uid=int.parse(time.toString().substring(1,time.toString().length-3));
      prefs.setInt('uid', uid);

    }
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: ()=>Get.back(),
          child: const Icon(Icons.arrow_back_ios_new)),
      ),
      body:Center(
        child:Column(
          children: [
            Image.asset('assets/notify.png'),
            const SizedBox(height: 10,),
            const Text('join  livestream now!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          children: [
            TextField(
              controller: _studentusername,
              decoration: InputDecoration(
                hintText: 'Enter your class name',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 8,),
     TextField(
      controller: _channelcode,
      decoration: InputDecoration(
        hintText: 'Enter your class code',
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
     ),
    TextButton(
      
      onPressed: () async {
      await [
        Permission.camera,
        Permission.microphone,
      ].request();
      Get.to( 
        
        MyClass(
      channelname: _channelcode.text,
      username: _studentusername.text, uid: uid,

    ));} ,child: const Text('Start'))
          ],
        )),
      
          ],
        )
      )


    );
  }
}