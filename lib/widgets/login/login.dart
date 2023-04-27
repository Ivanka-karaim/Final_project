import 'package:final_project/widgets/login/phone_number_input.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Введіть номер телефону',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(height: 20),
            PhoneNumberInput(
              phoneNumberController: _phoneNumberController,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              child: Text('Submit'),
            ),
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
