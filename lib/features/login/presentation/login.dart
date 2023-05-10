

import 'package:final_project/features/home/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/login/presentation/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/sign_in/sign_in_bloc.dart';
import '../bloc/sign_in/sign_in_event.dart';
import '../bloc/sign_in/sign_in_state.dart';
import '../../home/presentation/home_general/logo.dart';
import 'input.dart';


class LoginFormWidget extends StatefulWidget {
  final AuthBloc authBloc;
  const LoginFormWidget({super.key, required this.authBloc});

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
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          Center(
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
                  hint: '+38000000000',
                  obscure: false,
                ),
                const SizedBox(height: 16.0,),
                BlocListener<SignInBloc, SignInState>
                  (listener: (context, state){
                    if (state is SignInPhoneNumberSuccessful){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OtpWidget(authBloc: widget.authBloc)));

                    } else if(state is SignInPhoneNumberError) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error')));
                    } else if(state is SignInError){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));

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
        ],
      ),
    );
  }

  void _submitForm() {
    String phoneNumber = _phoneNumberController.text;
    _authBloc.add(PhoneNumberEvent(phoneNumber: phoneNumber));

  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }
}
