class Ticket {
  final int id;
  final int movieId;
  final String name;
  final DateTime date;
  final String image;
  final String smallImage;

  Ticket(
      this.id, this.movieId, this.name, this.date, this.image, this.smallImage);

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        json["id"],
        json["movieId"],
        json["name"],
        DateTime.fromMillisecondsSinceEpoch(json["date"] * 1000),
        json["image"],
        json["smallImage"]);
  }

  @override
  String toString() {
    return 'Ticket{id: $id, movieId: $movieId, name: $name, date: $date, image: $image, smallImage: $smallImage}';
  }
}
