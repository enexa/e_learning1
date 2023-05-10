import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


const primary = Color(0xFFf77080);
const secondary = Color(0xFFe96561);

const mainColor = Color(0xFF000000);
const darker = Color(0xFF3E4249);
const cardColor = Colors.white;
const appBgColor = Color(0xFFF7F7F7);
const appBarColor = Color(0xFFF7F7F7);
const bottomBarColor = Colors.white;
const inActiveColor = Colors.grey;
const shadowColor = Colors.black87;
const textBoxColor = Colors.white;
const textColor = Color(0xFF333333);
const glassTextColor = Colors.white;
const labelColor = Color(0xFF8A8989);
const glassLabelColor = Colors.white;
const actionColor = Color(0xFFe54140);
 Color kcolor=Get.isDarkMode?Colors.white:Colors.black;
 Color kcoloricon=Get.isDarkMode?Colors.black:Colors.white;

const Color bluishclr=Color(0xff0d47a1);
const Color yellowclr=  Color(0xffF9A825);
const Color whiteclr=Color(0xffFFFFFF);
const Color blackclr=Color(0xff000000);
const Color greyclr=Color(0xff9E9E9E);
const Color lightgreyclr=Color(0xffE0E0E0);
const Color darkgreyclr=Color(0xFF121212);
const Color redclr=Color(0xffD32F2F);
const Color pinkcolor=Color(0xffC2185B);
const Color greenclr=Color(0xff388E3C);
const Color blueclr=Color(0xff1976D2);
const Color lightblueclr=Color(0xff03A9F4);
const Color darkblueclr=Color(0xff0D47A1);
Color darkheaderclr=Colors.grey[800]!;


const yellow = Color(0xFFffcb66);
const green = Color(0xFFa2e1a6);
const pink = Color(0xFFf5bde8);
const purple = Color(0xFFcdacf9);
const red = Color(0xFFf77080);
const orange = Color(0xFFf5ba92);
const sky = Color(0xFFABDEE6);
const blue = Color(0xFF509BE4);

const listColors = [green, purple, yellow, orange, sky, secondary, red, blue, pink, yellow,];
class Themes{
  static  final lightTheme=ThemeData(
    backgroundColor: Colors.white,
    primaryColor: primary,
    brightness: Brightness.light,
  );
  static final darkTheme=ThemeData(
     backgroundColor: darkgreyclr,
    brightness: Brightness.dark,
    primaryColor:darkgreyclr,
  );
}

TextStyle  subheading(Color kcolor){
  return  TextStyle(
    fontFamily: 'Julee',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color:kcolor
      
    );
  
}
TextStyle  headingstyle(Color kcolor){
  return TextStyle(
    fontFamily: 'Julee',
      fontSize: 25,
      fontWeight: FontWeight.bold,
     color:kcolor
    );
 
}
TextStyle  titlestyle(Color kcolor){
  return TextStyle(
    
      fontFamily: 'Julee',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color:kcolor
      
    );
 
}
TextStyle  subtitlestyle(Color kcolor){
  return TextStyle(
    fontFamily: 'Julee',
      fontSize: 14,
      fontWeight: FontWeight.w400,
     color:kcolor
    );
  
}
TextStyle get newstyle{
  return TextStyle(
    
      fontFamily: 'Julee',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color:kcolor
      
    );
 
}
class Themeservice {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  bool get isDarkMode => _box.read(_key) ?? false;

  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    _box.write(_key, !isDarkMode);
  }

  void initTheme() {
    if (!_box.hasData(_key)) {
      _box.write(_key, false); // Set a default theme mode here
      themeMode == ThemeMode.dark ? switchTheme() : null;
     
    }
  }
}