import 'package:flutter/material.dart';

class Date extends StatelessWidget {
  final DateTime dateTime;
  final Map<int, String> map = {
    1: "Пн",
    2: "Вт",
    3: "Ср",
    4: "Чт",
    5: "Пт",
    6: "Сб",
    7: "Нд"
  };
  final bool isThisDate;

  Date({super.key, required this.dateTime, required this.isThisDate});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 90,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple, width: 3),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[900],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  decoration: isThisDate
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
            ),
            Center(
              child: Text(
                '${map[dateTime.weekday]}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    decoration: isThisDate
                        ? TextDecoration.underline
                        : TextDecoration.none),
              ),
            )
          ],
        ));
  }
}
