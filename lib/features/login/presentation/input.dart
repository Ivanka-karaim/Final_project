import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;

  const Input({super.key, required this.hint, required this.controller, required this.obscure});



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        obscureText: obscure,
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.deepPurple),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.deepPurple),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),

          filled: true,
          fillColor: Colors.black,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
        ),
      ),
    );
  }


}