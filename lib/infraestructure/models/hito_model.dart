import 'package:cloud_firestore/cloud_firestore.dart';

class HitoModel {
  final String id;
  final String image;
  final String? video;
  final String title;
  final int date;
  final String description;
  final String? category;
  final Person? created;

  HitoModel({
    required this.id,
    required this.image,
    this.video,
    required this.title,
    required this.date,
    required this.description,
    this.category,
    this.created,
  });

  factory HitoModel.fromMap(Map<String, dynamic> json) => HitoModel(
    id: json["id"],
    image: json["image"],
    video: json["video"],
    title: json["title"],
    date: json["date"],
    description: json["description"],
    category: json["category"],
    created:
        json["created"] == null ? null : Person.fromMap(json["created"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "image": image,
    "video": video,
    "title": title,
    "date": date,
    "description": description,
    "category": category,
    "created": created?.toMap(),
  };
}

class Person {
  final String? name;
  final String? email;
  final DateTime date;

  Person({
    this.name,
    this.email,
    required this.date,
  });

  factory Person.fromMap(Map<String, dynamic> json) {
    Timestamp timestamp = json["date"];

    DateTime date = DateTime.fromMillisecondsSinceEpoch(
      (timestamp.seconds * 1000) + timestamp.nanoseconds ~/ 1000000,
    );

    return Person(
      name: json["name"],
      email: json["email"],
      date: date.toLocal(),
    );
  }

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
    "date": date.toIso8601String(),
  };
}
