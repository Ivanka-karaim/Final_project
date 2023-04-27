import 'package:final_project/models/row.dart';

class Room {
  final int id;
  final String name;
  final List<Row> rows;

  Room(this.id, this.name, this.rows);

  factory Room.fromJson(Map<String, dynamic> json){
    List<Row> rows = [];
    for(int i=0; i<json["rows"].length; i++){
      rows.add(Row.fromJson(json["rows"][i]));
    }
    return Room(json["id"], json["name"], rows);
  }

  @override
  String toString() {
    return 'Room{id: $id, name: $name, rows: $rows}';
  }
}