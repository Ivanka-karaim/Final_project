import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(''),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
              // color: Colors.grey,
              width: 0.5), // колір та товщина межі
        ),
        actions: [
          IconButton(
            icon: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      AssetImage("assets/images/logo_new2.png"), // зображення
                ),
              ),
            ),
            // color: Colors.black,
            onPressed: () {},
          ),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
