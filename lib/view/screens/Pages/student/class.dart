

import 'package:flutter/material.dart';

class Class extends StatefulWidget {
  const Class({super.key});

  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
   List<String> _categories = ['IS', 'IT', 'SW', 'SW'];
  List<String> _years = ['1st', '2nd', '3rd', '4th'];

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Categories'),
      children: _categories
          .map((category) => ListTile(
                title: Text(category),
                onTap: () {
                  _showYears(context);
                },
              ))
          .toList(),
    );
  }

  void _showYears(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Years'),
          children: _years
              .map((year) => SimpleDialogOption(
                    child: Text(year),
                    onPressed: () {
                      Navigator.pop(context);
                      // do something when a year is clicked
                    },
                  ))
              .toList(),
        );
      },
    );
  }
}