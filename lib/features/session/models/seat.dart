class Seat {
  final int id;
  final int index;
  final int type;
  final int price;
  final bool isAvailable;

  Seat(this.id, this.index, this.type, this.price, this.isAvailable);

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(json["id"], json["index"], json["type"], json["price"],
        json["isAvailable"]);
  }

  @override
  String toString() {
    return 'Seat{id: $id, index: $index, type: $type, price: $price, isAvailable: $isAvailable}';
  }
}
