// To parse this JSON data, do
//
//     final macotaRespuesta = macotaRespuestaFromMap(jsonString);

import 'dart:convert';

class Mascota {
    Mascota({
        this.nombre,
        this.imagen,
        this.pedigree,
        required this.color,
        this.edad,
        required this.estado,
        required this.raza,
        this.duenho,
    });

    String? nombre;
    String? imagen;
    bool? pedigree;
    String color;
    String? edad;
    String estado;
    String raza;
    String? duenho;

    factory Mascota.fromJson(String str) => Mascota.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Mascota.fromMap(Map<String, dynamic> json) => Mascota(
        nombre: json["nombre"],
        imagen: json["imagen"],
        pedigree: json["pedigree"],
        color: json["color"],
        edad: json["edad"],
        estado: json["estado"],
        raza: json["raza"],
        duenho: json["duenho"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "imagen": imagen,
        "pedigree": pedigree,
        "color": color,
        "edad": edad,
        "estado": estado,
        "raza": raza,
        "duenho": duenho,
    };
}
