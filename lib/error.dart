import 'package:final_project/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Error extends StatelessWidget{
  final String error;
  const Error({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text('Ooopss\nЩось пішло не так!!!', style: TextStyle(color: Colors.deepPurple)),
              Text(error, style: TextStyle(color: Colors.deepPurple),),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              }, child: const Text('Повернутись на головну', style: TextStyle(color: Colors.white),),),
            ],
          ),
        )
      ),

    );

  }

}