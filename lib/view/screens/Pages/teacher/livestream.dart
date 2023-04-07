


import 'package:e_learning/view/screens/Pages/teacher/start_stream.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class Livestream extends StatefulWidget {
  const Livestream({super.key});

  @override
  State<Livestream> createState() => _LivestreamState();
}
  
class _LivestreamState extends State<Livestream> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _channelname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            const Text('start live stream class', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
          const   SizedBox(height: 10,),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          children: [
            TextField(
              controller: _username,
              decoration: InputDecoration(
                hintText: 'Enter your class name',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
              TextField(
      controller: _channelname,
      decoration: InputDecoration(
        hintText: 'Enter your class code',
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
     ),
      
    TextButton(
      style:    TextButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        )
      ),
      
      onPressed: ()=>Get.to( Online(
      channelname: _channelname.text,
    
    )), child: const Text('Start'))
          ],
        ),
        
   
         ) ],
        )
      )


    );
  }
}