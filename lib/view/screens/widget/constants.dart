
// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'package:flutter/material.dart';

// sudo /opt/lampp/manager-linux-x64.run
Widget buildPage(
    {required Color color,
    required String urlImage,
    required String title,
    required String subtitle}) {
  return Stack(fit: StackFit.expand,

    children: [
      Container(
        color: color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Image(image: AssetImage(urlImage), fit: BoxFit.cover,width: double.infinity,
          height: 250,),
        
       
    
        
        const SizedBox(height: 20),
        Text(title, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        Container(
          padding:const  EdgeInsets.symmetric(vertical: 20),
          child: Text(subtitle, style: const TextStyle(fontSize: 20)),
        ),
      ],
    ),
  ) ]);
    
}
const baseURL = 'http://10.42.0.1:8000/api';
const loginURL = '$baseURL/login';

const registerURL = '$baseURL/register';

const logoutURL = '$baseURL/logout';
const userURL = '$baseURL/user';
const postsURL = '$baseURL/posts';
const commentsURL = '$baseURL/comments';

// ----- Errors -----
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';

// --- input decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.all(10),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(width: 1, color: Colors.black)));
}

// button

TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
            (states) =>  Colors.blue),
        padding: MaterialStateProperty.resolveWith(
            (states) => const EdgeInsets.symmetric(vertical: 10))),
    onPressed: () => onPressed(),
    child:  Text(
      label,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

// loginRegisterHint
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
             const SizedBox(width: 4),
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





















