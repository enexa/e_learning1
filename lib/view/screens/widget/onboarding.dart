// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/student/login.dart';
import 'constants.dart';



class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController controller = PageController();
  bool islastpage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: context.theme.backgroundColor,
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() => islastpage = index == 2);
            },
            children: [
              buildPage(
           
                urlImage: 'assets/e3.png',
                title: 'Welcome to Bahir Dar University e-learning \n Arevolution in learning, the evolution of you',
                subtitle: 'join us now',
              ),
              buildPage(
             
                urlImage: 'assets/e1.png',
                title: 'on-demand courses and bite-sized videos \n               to fit your schedule',
                subtitle: 'Learn anything you want',
              ),
              buildPage(   
             
                urlImage: 'assets/e2.png',
                title: 'Discover the most in-demand skills',
                subtitle: 'Start Now',
              ),
            ],
          ),
        ),
        bottomSheet: islastpage
            ?  Container(
                height: 80,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      primary: Colors.white,
                      minimumSize: const Size(double.infinity, 80),
                      backgroundColor: Colors.blue,),
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () => controller.jumpToPage(2),
                      child: const Text('Skip'),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.blue,
                        ),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn),
                      ),
                    ),
                    TextButton(
                      onPressed: () => controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      ),
                      child: const Text('Next',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                )),
      ),
    );
  }
}
