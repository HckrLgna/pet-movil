// To parse this JSON data, do
//
//     final pet = petFromMap(jsonString);

import 'dart:convert';

class Pet {
    Pet({
        required this.found,
        required this.name,
        this.picture,
        this.reward,
        this.id
    });

    bool found;
    String name;
    String? picture;
    int? reward;
    String? id;

    factory Pet.fromJson(String str) => Pet.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Pet.fromMap(Map<String, dynamic> json) => Pet(
        found: json["found"],
        name: json["name"],
        picture: json["picture"],
        reward: json["reward"],
    );

    Map<String, dynamic> toMap() => {
        "found": found,
        "name": name,
        "picture": picture,
        "reward": reward,
    };
    Pet copy()=> Pet(
      found: this.found, 
      name: this.name,
      picture: this.picture,
      reward: this.reward,
      id: this.id,
      );
}
