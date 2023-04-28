
import 'package:final_project/widgets/login/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../bloc/sign_in/sign_in_bloc.dart';
import '../../bloc/sign_in/sign_in_event.dart';
import '../../bloc/sign_in/sign_in_state.dart';
import '../logo.dart';
import 'otp.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  late final SignInBloc _authBloc;
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _authBloc = BlocProvider.of<SignInBloc>(context);
  }
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
            Input(
              controller: _phoneNumberController,
              hint: '+38000000000'
            ),
            const SizedBox(height: 16.0,),
            BlocListener<SignInBloc, SignInState>
              (listener: (context, state){
                if (state is SignInPhoneNumberSuccessful){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpWidget()));

                } else if(state is SignInPhoneNumberError) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error')));
                }
            },
              child: ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepPurple)),
              child: const Text('Надіслати'),
            ), ),
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
    _authBloc.add(PhoneNumberEvent(phoneNumber: phoneNumber));
    print('Submitted phone number: $phoneNumber');
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }
}