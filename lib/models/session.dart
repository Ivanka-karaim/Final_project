import 'package:final_project/models/room.dart';
import 'package:final_project/models/row.dart';

class Session {
  final int id;
  final DateTime date;
  final String type;
  final int minPrice;
  final Room room;
  // final List<Row> rows;

  Session(this.id, this.date, this.type, this.minPrice, this.room);

  factory Session.fromJson(Map<String, dynamic> json){

    return Session(json["id"],  DateTime.fromMillisecondsSinceEpoch(json["date"] * 1000), json["type"], json["minPrice"], Room.fromJson(json["room"]));
  }

  @override
  String toString() {
    return 'Session{id: $id, date: $date, type: $type, minPrice: $minPrice, room: $room}';
  }
}
