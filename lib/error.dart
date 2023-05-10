import 'package:final_project/features/movies/presentation/movie_navigator.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String error;

  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              children: [
                const Text('Ooopss\nЩось пішло не так!!!',
                    style: TextStyle(color: Colors.deepPurple)),
                Text(
                  error,
                  style: const TextStyle(color: Colors.deepPurple),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MovieNavigator(),
                      ),
                    );
                  },
                  child: const Text(
                    'Повернутись на головну',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
