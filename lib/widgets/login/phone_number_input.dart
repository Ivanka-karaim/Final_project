import 'package:flutter/material.dart';

// class PhoneNumberInput extends StatefulWidget {
//
//   const PhoneNumberInput({super.key});
//
//   @override
//   State<PhoneNumberInput> createState() => _PhoneNumberInputState();
// }

class PhoneNumberInput extends StatelessWidget {
  final TextEditingController phoneNumberController;

  const PhoneNumberInput({super.key, required this.phoneNumberController});



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(

        controller: phoneNumberController,
        keyboardType: TextInputType.phone,
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
          hintText: '+380000000000',
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