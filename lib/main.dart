
import 'package:final_project/bloc/auth/auth_state.dart';
import 'package:final_project/datasource/token_local_data_source.dart';
import 'package:final_project/repository/authorization.dart';
import 'package:final_project/widgets/login/login.dart';
import 'package:final_project/widgets/login/login_screen.dart';
import 'package:final_project/widgets/movies/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/auth/auth_event.dart';
import 'bloc/sign_in/sign_in_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthBloc authBloc;

  @override
  void initState() {

    authBloc = AuthBloc();
    authBloc.add(CheckUserEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(bloc: authBloc,builder:
    (context, state){
      return state is AuthSuccessful ? MoviePage():LoginScreen();
    }, listener: (context, state){});
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  static String accessToken = '';

  Future<void> _incrementCounter() async {
    AuthorizationRepository auth = AuthorizationRepository();
    if (accessToken == '') {
      String response = await auth.authorization("+380667236485");
      setState(() {
        accessToken = response;
      });
    }
    await auth.getUser(accessToken);
    await auth.changeUser({"name": "Ivanna"}, accessToken);
    await auth.getUserTickets(accessToken);
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
