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
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(

        controller: phoneNumberController,
        keyboardType: TextInputType.phone,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: '+380000000000',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.black,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
        ),
      ),
    );
  }


}