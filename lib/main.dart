import 'package:e_learning/view/screens/home.dart';
import 'package:e_learning/view/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view/screens/home1.dart';




Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'e-learning',
      debugShowCheckedModeBanner: false,
      home: const Onboarding(),
      // showHome ? Login() :
    );
  }
}
