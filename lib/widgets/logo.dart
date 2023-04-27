import 'package:flutter/material.dart';
class Logo extends StatelessWidget{
  final double width;
  const Logo({super.key, required this.width});


  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage("assets/images/logo_new2.png"),
      width: width,
      fit: BoxFit.cover,
    );
  }

}