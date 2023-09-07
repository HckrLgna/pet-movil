// To parse this JSON data, do
//
//     final loginRespuesta = loginRespuestaFromMap(jsonString);

import 'dart:convert';

class LoginRespuesta {
    LoginRespuesta({
        required this.success,
        this.msg,
        this.accesToken,
        this.errors,
    });

    final bool success;
    final String? msg;
    final String? accesToken;
    final String? errors;

    factory LoginRespuesta.fromJson(String str) => LoginRespuesta.fromMap(json.decode(str)); 

    factory LoginRespuesta.fromMap(Map<String, dynamic> json) => LoginRespuesta(
        success: json["success"],
        msg: json["msg"],
        accesToken: json["acces_token"],
        errors: json["errors"].toString(),
    );   
}

class Errors {
    Errors({
        this.email,
        this.password,
    });

    final List<String>? email;
    final List<String>? password;

    factory Errors.fromJson(String str) => Errors.fromMap(json.decode(str));    

    factory Errors.fromMap(Map<String, dynamic> json) => Errors(
        email: List<String>.from(json["email"].map((x) => x)),
        password: List<String>.from(json["password"].map((x) => x)),
    );

    
}
