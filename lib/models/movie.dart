class Movie{
   final int id;
   final String name;
   final int age;
  final String trailer;
   final String image;
   final String smallImage;
   final String originalName;
   final int duration;
  final String language;
   final String rating;
  final String country;
  final String genre;
  final String plot;
  final String starring;
  final String director;
  final String screenwriter;
  final String studio;

  Movie(
      this.id,
      this.name,
      this.age,
      this.trailer,
      this.image,
      this.smallImage,
      this.originalName,
      this.duration,
      this.language,
      this.rating,
      this.country,
      this.genre,
      this.plot,
      this.starring,
      this.director,
      this.screenwriter,
      this.studio);

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(json["id"], json["name"], json["age"], json["trailer"], json["image"], json["smallImage"], json["originalName"], json["duration"], json["language"], json["rating"], json["country"], json["genre"], json["plot"], json["starring"], json["director"], json["screenwriter"], json["studio"]);

  }

  @override
  String toString() {
    return 'Movie{id: $id, name: $name, age: $age, trailer: $trailer, image: $image, smallImage: $smallImage, originalName: $originalName, duration: $duration, language: $language, rating: $rating, country: $country, genre: $genre, plot: $plot, starring: $starring, director: $director, screenwriter: $screenwriter, studio: $studio}';
  }
}