// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';


import '../colors.dart';

import 'image.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem({ Key? key, required this.data, this.width = 280, this.height = 290, this.onTap}) : super(key: key);
  final data;
  final double width;
  final double height;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return 
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 5, top: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              CustomImage(data["image"],
                width: double.infinity, height: 190,
                radius: 15,
              ),
              Positioned(
                top: 170, right: 15,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                 
                ),
              ),
              Positioned(
                top: 210,
                child: Container(
                  width: width - 20,
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data["name"], maxLines: 1, overflow: TextOverflow.ellipsis, 
                        style: const TextStyle(fontSize: 17, color: textColor, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getAttribute(Icons.play_circle_outlined, labelColor, data["session"]),
                          const SizedBox(width: 12,),
                          getAttribute(Icons.schedule_rounded, labelColor, data["duration"]),
                          const SizedBox(width: 12,),
                          getAttribute(Icons.star, yellow, data["review"]),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }

  getAttribute(IconData icon, Color color, String info){
    return
      Row(
        children: [
          Icon(icon, size: 18, color: color,),
          const SizedBox(width: 3,),
          Text(info, maxLines: 1, overflow: TextOverflow.ellipsis, 
            style: const TextStyle(color: labelColor, fontSize: 13),
          ),
        ],
      );
  }

}