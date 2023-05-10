
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/local_db.dart';
import 'view/screens/Pages/student/home.dart';
import 'view/screens/Pages/student/home1.dart';
import 'view/screens/colors.dart';
import 'view/screens/widget/onboarding.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await DBHelper.initDb();
  await GetStorage.init();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({Key? key, required this.showHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Homewillbe()),
        GetPage(name: '/second', page: () =>const Try()),
      ],
       theme: Themes.lightTheme,

      darkTheme: Themes.darkTheme,
      themeMode: Themeservice().themeMode,
      title: 'e-learning',
      debugShowCheckedModeBanner: false,
      home: const Onboarding(),
      // showHome ? Login() :
    );
  }
}
