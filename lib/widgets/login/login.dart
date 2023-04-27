import 'package:final_project/widgets/login/phone_number_input.dart';
import 'package:flutter/material.dart';

import '../logo.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Logo(
              width: 150,
            ),
            const SizedBox(
              height: 75,
            ),
            const Text(
              'Введіть номер телефону',
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
            const SizedBox(height: 20,),
            PhoneNumberInput(
              phoneNumberController: _phoneNumberController,
            ),
            const SizedBox(height: 16.0,),
            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepPurple)),
              child: const Text('Надіслати'),
            ),
            const SizedBox(height: 150)
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    // Do something with the phone number
    String phoneNumber = _phoneNumberController.text;
    print('Submitted phone number: $phoneNumber');
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }
}
