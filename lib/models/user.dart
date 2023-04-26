class User {
  final int id;
  final String name;
  final String phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  User(this.id, this.name, this.phoneNumber, this.createdAt, this.updatedAt);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json["id"],
        json["name"],
        json["phoneNumber"],
        DateTime.fromMillisecondsSinceEpoch(json["createdAt"] * 1000),
        DateTime.fromMillisecondsSinceEpoch(json["updatedAt"] * 1000));
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, phoneNumber: $phoneNumber, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
