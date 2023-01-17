// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'login.dart';


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
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() => islastpage = index == 2);
            },
            children: [
              buildPage(
                color: Colors.white,
                urlImage: 'https://unsplash.com/photos/Z-4MrsOMR2E',
                title: 'Welcome to e-learning',
                subtitle: 'Learn anything you want',
              ),
              buildPage(
                color: Colors.white,
                urlImage: 'https://www.istockphoto.com/photo/webinar-e-learning-skills-business-internet-technology-concepts-training-webinar-e-gm1366428092-436952254?utm_source=unsplash&utm_medium=affiliate&utm_campaign=srp_photos_top&utm_content=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Felearning&utm_term=elearning%3A%3A%3A',
                title: 'Learn from anywhere',
                subtitle: 'Learn anything you want',
              ),
              buildPage(
                color: Colors.white,
                urlImage: 'https://www.istockphoto.com/photo/smart-student-learning-using-internet-and-headphones-gm1128717611-297922748?utm_source=unsplash&utm_medium=affiliate&utm_campaign=srp_photos_top&utm_content=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fvedeo-classs&utm_term=vedeo%20classs%3A%3A%3A',
                title: 'Learn from anyone',
                subtitle: 'Learn anything you want',
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
