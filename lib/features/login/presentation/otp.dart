import 'package:final_project/features/home/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/home/bloc/auth/auth_event.dart';
import 'package:final_project/features/login/bloc/sign_in/sign_in_bloc.dart';
import 'package:final_project/features/login/bloc/sign_in/sign_in_event.dart';
import 'package:final_project/features/login/bloc/sign_in/sign_in_state.dart';
import 'package:final_project/features/login/presentation/input.dart';
import 'package:final_project/main.dart';
import 'package:final_project/features/home/presentation/home_general/logo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpWidget extends StatefulWidget {
  final AuthBloc authBloc;
  const OtpWidget({super.key, required this.authBloc});

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  late final SignInBloc _authBloc;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
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
                  'Введіть код,\n що прийшов на номер телефону',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Input(
                  controller: _controller,
                  hint: '0000',
                  obscure: false,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                BlocListener<SignInBloc, SignInState>(
                  listener: (context, state) {
                    if (state is SignInSuccessful)
                    {
                      widget.authBloc.add(CheckUserEvent());

                      // Navigator.pop(context);
                      // Navigator.popUntil(context, (route) => route.isFirst);
                      // Navigator.of(context).popUntil((route) => route.isFirst);


                      // Navigator.pop(context);
                      // Navigator.of(context).popUntil((route) => false);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (conteRxt) => const MyApp()));
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Welcome')));
                    } else if (state is SignInPasswordError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Error')));
                    }
                  },
                  child: Column(children: [
                    ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple)),
                      child: const Text('Надіслати'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitFormWithoutPassword();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple)),
                      child: const Text('Пароль не надійшов'),
                    ),
                  ]),
                ),
                const SizedBox(height: 150)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    // Do something with the phone number
    String otp = _controller.text;

    _authBloc.add(AuthorizationEvent(password: otp));
  }

  void _submitFormWithoutPassword() {
    _authBloc.add(AuthorizationEvent(password: "0000"));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
