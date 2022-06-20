import 'dart:convert';

List<ListClass> listClassFromJson(String str) => List<ListClass>.from(json.decode(str).map((x) => ListClass.fromJson(x)));

// String listClassToJson(List<ListClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListClass {
  ListClass({
    required this.name,
    required this.description,
    required this.id,
    required this.image,
  });

  String? name;
  String? description;
  String? id;
  String? image;

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
    name: json["name"].toString(),
    description: json["description"].toString(),
    id: json["id"].toString(),
    image: json["image"].toString(),
  );

  // Map<String, dynamic> toJson() => {
  //   "name": name,
  //   "description": description,
  // };
}