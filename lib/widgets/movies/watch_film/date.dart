

import 'package:flutter/material.dart';

class Date extends StatelessWidget{
  final String text;

  const Date({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return SizedBox(width:100, child: Text(text));
  }

}