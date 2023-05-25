
// ignore_for_file: non_constant_identifier_names, duplicate_ignore


import 'package:flutter/material.dart';


import '../colors.dart';


// sudo /opt/lampp/manager-linux-x64.run
Widget buildPage(
    {
    required String urlImage,
    required String title,
    required String subtitle}) {
  return Stack(fit: StackFit.expand,

    children: [
   
      // ignore: avoid_unnecessary_containers
      Container(
       
     
    
  
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
//        
// ),
        Image.asset(
          urlImage,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 250,
        ),
        const SizedBox(height: 20),
        Text(title, style: newstyle),
        const SizedBox(height: 20),
        Container(
          padding:const  EdgeInsets.symmetric(vertical: 20),
          child: Text(subtitle, style: newstyle),
  

        ),
      ],
    ),
  ) ]);
    
}
ButtonStyle myStyle(){
  return ButtonStyle(shape:       
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.blue)
                        )
                      )
                    );
}
const appId="52e41f55a5d14274a6b80f1d982bf3b4";
const baseURL = 'http://192.168.0.15:8000/api';
const loginURL = '$baseURL/login';
const teacherloginURL = '$baseURL/teacher-login';
const registerURL = '$baseURL/register';
const pdfURL = '$baseURL/pdf';
const changepasswordURL = '$baseURL/change-password';

const logoutURL = '$baseURL/logout';
const userURL = '$baseURL/user';
const postsURL = '$baseURL/announcements';
const commentsURL = '$baseURL/comments';
const forumsURL = '$baseURL/forums';
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.all(10),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(width: 1, color: Colors.black)));
}


TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    style:   ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
      padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(vertical: 10))
    ),
    onPressed: () => onPressed(),
    child:  Text(
      label,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
          child: Text(label, style: const TextStyle(color: Colors.blue)),
          onTap: () => onTap())
    ],
  );
}

// likes and comment btn

Expanded kLikeAndComment(
    int value, IconData icon, Color color, Function onTap) {
  return Expanded(
    child: Material(
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              const   Text(
                     'Answer'
                    ),
              Text('$value')
            ],
          ),
        ),
      ),
    ),
  );
}
 
 // ignore: non_constant_identifier_names
 Container Kcontainer(String subject,String chapter,String time,Icon myicon){
  return Container(
    padding:const  EdgeInsets.all(8.0),
          decoration:  BoxDecoration(
                color:Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3), //
      )
  ]  ),
      
      height: 150,
      width: 100,
      child: Column(
        children:  [
          myicon,
           Text(subject),
           Text(chapter),
          Row(children:  [const Icon(Icons.alarm),
          Text(time),
          ],)
        ],
      ),
    );
}
Container Kblur(Widget child){
  return Container(decoration: BoxDecoration(
   boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
       
        blurRadius: 20,
        offset:const  Offset(0, 1), // changes position of shadow
      ),
    ],
 ),child: child,);
}




















