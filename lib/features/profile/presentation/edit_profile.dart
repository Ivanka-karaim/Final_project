import 'package:final_project/features/login/presentation/input.dart';
import 'package:final_project/features/profile/bloc/profile/profile_bloc.dart';
import 'package:final_project/features/profile/bloc/profile/profile_event.dart';
import 'package:final_project/features/profile/bloc/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final ProfileBloc profileBloc;

  EditProfilePage({super.key, required this.profileBloc});

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
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Повернутись у профіль',
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                const Text(
                  'Введіть імя',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Input(
                  controller: _controller,
                  hint: 'Ivanna',
                  obscure: false,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                BlocListener<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileInformation) {
                      Navigator.pop(context);
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      _submitForm();
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepPurple)),
                    child: const Text(
                      'Надіслати',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 150)
              ],
            ),
          ),
        ],
      ),
    );
  }

  _submitForm() {
    String name = _controller.text;
    profileBloc.add(ChangeUserEvent(name: name));
  }
}
