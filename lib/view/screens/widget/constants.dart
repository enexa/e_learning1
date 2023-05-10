
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
const appId="52e41f55a5d14274a6b80f1d982bf3b4";
const baseURL = 'http://10.42.0.1:8000/api';
const loginURL = '$baseURL/login';
const teacherloginURL = '$baseURL/teacher-login';
const registerURL = '$baseURL/register';
const pdfURL = '$baseURL/pdf';
const changepasswordURL = '$baseURL/change-password';

const logoutURL = '$baseURL/logout';
const userURL = '$baseURL/user';
const postsURL = '$baseURL/announcements';
const commentsURL = '$baseURL/forum';
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

const url1= 'https://youtu.be/TAmZn2f7Pg8';
const url2= 'https://youtu.be/8pEwAD0IZ0k';
const url3= 'https://youtu.be/pJgDUn8K_Sg';
const url4= 'https://youtu.be/QCbG9qTfrgM';
const url5= 'https://youtu.be/lxLBLitLNxw';
const url6= 'https://youtu.be/BJWmWzFKmtA';
const url7= 'https://youtu.be/3FWqwicdMQk';
const url8= 'https://youtu.be/7fdcpGek26E';
const url9= 'https://youtu.be/Ywarmy4GK0Y';
const url10= 'https://youtu.be/eOt7sM5kCO4';
const url11= 'https://youtu.be/xGY_rsJ3w70';
const url12= 'https://youtu.be/yRQzW-FSAgM';
const url13= 'https://youtu.be/1L2kLy5MEnc';
const url14= 'https://youtu.be/6_Bkn7Qxr5E';
const url15= 'https://youtu.be/sKoiv7wOD3M';
const url16= 'https://youtu.be/Frj9MoyraL4';
const url17='https://youtu.be/B4xRbOOhccI';
const url18='https://youtu.be/4iCMdVduHoU';
const url19='https://youtu.be/frxqMNDbQ6o';
const url20='https://youtu.be/RZ0gvM6kxZE';
const url21='https://youtu.be/eoRO5ZE5QMs';
const url22='https://youtu.be/w5wg0IU2MnM';
const url23='https://youtu.be/r-R70t1U600';
const url24='https://youtu.be/r9LYTMCZc3Q';
const url25='https://youtu.be/MSYnCIrSnz0';
const url26='https://youtu.be/EGSZUBYi0Ds';
const url27='https://youtu.be/mVyibIv7O2E';
const url28='https://youtu.be/Ph68Z56cYdk';
const url29='https://youtu.be/gMMyAiTUToc';
const url30='https://youtu.be/tgeJIt1C-Uk';
const url31='https://youtu.be/oR4G3o_WBUw';
const url32='https://youtu.be/bjVyzq8zaXA';
const url33='https://youtu.be/QjBNGJ9SNL0';
const url34='https://youtu.be/itrgskrWW_Y';
const url35='https://youtu.be/CiQIEJGS3Bs';
const url36='https://youtu.be/w8Rdke7Ji00';
const url37='https://youtu.be/edyRjfJOfmk';
const url38='https://youtu.be/edyRjfJOfmk';
const url39='https://youtu.be/sCq53P1lWak';
const url40='https://youtu.be/oyBxE1nqjR0';
const url41='https://youtu.be/UCTIwrulQ-o';
const url42='https://youtu.be/KMCZXq-mxrc';
const url43='https://youtu.be/tNap0Dk0Ew4';
const url44='https://youtu.be/59_Xd8GOyB0';
const url45='https://youtu.be/vxfebqz6bFQ';
const url46='https://youtu.be/ZC6nB38ieXk';
const url47='https://youtu.be/r8X-14mYwLI';
const url48='https://youtu.be/cmcLjIiNl2E';
const url49='https://youtu.be/xCn0JDY5fiA';
const url50='https://youtu.be/xgYADM7fTOo';
const url51='https://youtu.be/Ln_ETAmDZjQ';
const url52='https://youtu.be/Z3cyA7nCllk';
const url53='https://youtu.be/JJFbURKftA8';
const url54='https://youtu.be/rPE7FlEFiDw';
const url55='https://youtu.be/6sNqPDFfkj4';
const url56='https://youtu.be/dlx8AkYRCnk';
const url57='https://youtu.be/hoqI_KgQQwk';
const url58='https://youtu.be/MaErb5ERFQo';
const url59='https://youtu.be/kY7RezPwCe4';
const url60='https://youtu.be/DGMWtSgjgDo';
const url61='https://youtu.be/5nomzP5fTrI';
const url62='https://youtu.be/b_ANDq-6-ao';
const url63='https://youtu.be/3d7DD_tMZoA';
const url64='https://youtu.be/syYhZVx-Grw';
const url65='https://youtu.be/R0vHdyB_MYI';
const url66='https://youtu.be/_kKULch5ycs';
const url67='https://youtu.be/fE44o98Fp1s';
const url68='https://youtu.be/vbvcwg7X50Y';
const url69='https://youtu.be/nJYV1XooMeY';
const url70='https://youtu.be/ZbYTYXYjbhU';
const url71='https://youtu.be/_rUd_svz4E0';
const url72='https://youtu.be/wCkaFiQCxOk';
const url73='https://youtu.be/WnpO4tPir1Y';
const url74='https://youtu.be/cD8N_pGWoU8';
const url75='https://youtu.be/IOMWuOMPdA0';
const url76='https://youtu.be/lUOT3W1JIFQ';
const url77='https://youtu.be/mwtoaoEn6Po';
const url78='https://youtu.be/owrEz2yNtTU';
const url79='https://youtu.be/g3PwEu-4dn4';
const url80='https://youtu.be/_kz38wG239Y';
const url81='https://youtu.be/WHNbSg6kJOc';
const url82='https://youtu.be/Mr_gKRveTAY';
const url83='https://youtu.be/EmUKmGSl2QY';
const url84='https://youtu.be/fIM5rybSKb4';
const url85='https://youtu.be/8882iQUd9_w';
const url86='https://youtu.be/lUOT3W1JIFQ';
const url87='https://youtu.be/MMmWhLDZR7A';



















