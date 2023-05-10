class Ticket {
  final int id;
  final int movieId;
  final String name;
  final DateTime date;
  final String image;
  final String smallImage;
  final int seatIndex;
  final int rowIndex;
  final String roomName;

  Ticket(this.id, this.movieId, this.name, this.date, this.image,
      this.smallImage, this.seatIndex, this.rowIndex, this.roomName);

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        json["id"],
        json["movieId"],
        json["name"],
        DateTime.fromMillisecondsSinceEpoch(json["date"] * 1000),
        json["image"],
        json["smallImage"],
        json["seatIndex"],
        json["rowIndex"],
        json["roomName"]);
  }

  @override
  String toString() {
    return '$id$movieId$rowIndex$seatIndex';
  }
}
