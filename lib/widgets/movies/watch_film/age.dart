import 'package:flutter/material.dart';

class Age extends StatelessWidget{
  final int age;

  const Age({super.key, required this.age});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 36,
      width: 36,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              color: Colors.deepPurple, width: 1),
        ),
        child: Center(
          child: Text(
            '${age}+',
            style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w600
            ),
          ),
        ),
      ),
    );
  }

}