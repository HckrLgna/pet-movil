import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends ChangeNotifier{
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken ='AIzaSyCRe3SVBZ1mqsu-JG6fDVdhOQzFUUT7hNA';
  final storage = new FlutterSecureStorage();

  //si se retorna algo es un error
  Future<String?> createUser (String email, String password)async{
    final Map<String,dynamic> authData={
      'email': email,
      'password': password,
      'returnSecureToken': true

    };
    final url = Uri.https(_baseUrl,'/v1/accounts:signUp',{
      'key':_firebaseToken,
    });
    final resp = await http.post(url,body: json.encode(authData));
    final Map<String,dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    if(decodeResp.containsKey('idToken')){
      //token hay que guardarlo en un lugar seguro
      //return decodeResp['idToken'];
      await storage.write(key:'token', value: decodeResp['idToken']);
      return null;
    }else{
      
      return decodeResp['error']['message'];
    }
  }

  Future<String?> login (String email, String password)async{
    final Map<String,dynamic> authData={
      'email': 'jaime@correo.com',
      'password': '123456',
      'returnSecureToken': true
    };
    final url = Uri.https(_baseUrl,'/v1/accounts:signInWithPassword',{
      'key':_firebaseToken,
    });
    final resp = await http.post(url,body: json.encode(authData));
    final Map<String,dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    if(decodeResp.containsKey('idToken')){
      //token hay que guardarlo en un lugar seguro
      //return decodeResp['idPToken'];
      await storage.write(key: 'token', value: decodeResp['idToken']);
      return null;
    }else{
      return decodeResp['error']['message'];
    }
  }
  Future logout()async{
    await storage.delete(key: 'token');
    return;
  }
  Future<String> readToken() async{
    return await storage.read(key: 'token') ?? '';
  }

}