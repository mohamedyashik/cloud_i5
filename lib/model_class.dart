class User {
  int id;
  String name;
  String image;
  int price;

  User(
      {required this.id,
      required this.name,
      required this.image,
      required this.price});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        price: json['price']);
  }
}