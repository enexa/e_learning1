import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class Class extends StatefulWidget {
  const Class({super.key});

  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: ListView(
        children:  [
          const Text('POPULAR MENTORS'),
          Expanded(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const[
                CircleAvatar(radius: 28,child: Icon(FontAwesomeIcons.person),),
                 CircleAvatar(radius: 28,child: Icon(FontAwesomeIcons.person),),
                  CircleAvatar(radius: 28,child: Icon(FontAwesomeIcons.person),),
                   CircleAvatar(radius: 28,child: Icon(FontAwesomeIcons.person),),
                    CircleAvatar(radius: 28,child: Icon(FontAwesomeIcons.person),),
                    CircleAvatar(radius: 28,child: Icon(FontAwesomeIcons.person),),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}