
import 'package:flutter/material.dart';

import '../colors.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()?onTap;
const MyButton({Key?key,required this.label,required this.onTap}):super(key: key);
  // const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: onTap,
      child:Container(
        width: 100,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bluishclr
        ),
        child: Center(
          child: Text(
            label,

            style: const TextStyle(
              color: Colors.white,
              
            ),
          ),
        ),
      ) ,

    );
  }
}