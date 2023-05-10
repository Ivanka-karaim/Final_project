import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  bool isDate;

  Input({super.key, required this.hint, required this.controller, required this.obscure, this.isDate=false});



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

        onChanged: (value) {
          if (isDate) {
            if (value.length == 2 && !controller.text.endsWith('/')) {
              controller.text += '/';
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
            }
          }
        },
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