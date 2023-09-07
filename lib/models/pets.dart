// To parse this JSON data, do
//
//     final pet = petFromMap(jsonString);

import 'dart:convert';

class Pet {
    Pet({
        required this.found,
        required this.name,
        this.location,
        this.picture,
        this.reward,
        this.id
    });

    bool found;
    String name;
    String? location;
    String? picture;
    int? reward;
    String? id;

    factory Pet.fromJson(String str) => Pet.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Pet.fromMap(Map<String, dynamic> json) => Pet(
        found: json["found"],
        name: json["name"],
        location: json["location"],
        picture: json["picture"],
        reward: json["reward"],
    );

    Map<String, dynamic> toMap() => {
        "found": found,
        "name": name,
        "location" : location,
        "picture": picture,
        "reward": reward,
    };
    Pet copy()=> Pet(
      found: found, 
      name: name,
      location: location,
      picture: picture,
      reward: reward,
      id: id,
      );
}
