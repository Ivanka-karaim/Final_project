import 'package:final_project/features/session/models/seat.dart';

class Row {
  final int id;
  final int index;
  final List<Seat> seats;

  Row(this.id, this.index, this.seats);

  factory Row.fromJson(Map<String, dynamic> json) {
    List<Seat> seats = [];
    for (int i = 0; i < json["seats"].length; i++) {
      seats.add(Seat.fromJson(json["seats"][i]));
    }
    return Row(json["id"], json["index"], seats);
  }

  @override
  String toString() {
    return 'Row{id: $id, index: $index, seats: $seats}';
  }
}
