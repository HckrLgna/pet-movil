import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pets_movil/models/models.dart';

class AuthService2 extends ChangeNotifier{
  final String _baseUrl = '54.87.50.127';
  final storage = const FlutterSecureStorage();

  Future<String?> createUser ( String name, String email, String password, String passwordConfirmation) async {
    if ( password != passwordConfirmation ){
      return 'Las contraseñas no coinciden';
    }
    final Map<String,dynamic> authData={
      'name' : name,      
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation
    };    
    final url = Uri.http( _baseUrl, '/api/register' );
    final resp = await http.post(url,body: authData );
    final respuesta = LoginRespuesta.fromJson( resp.body );    
    if( respuesta.success ){      
      await storage.write(key: 'token', value: respuesta.accesToken );
      return null;
    }else{
      return 'El correo ya esta registrado';
    }
  }

  Future<String?> login ( String email, String password ) async {
    final Map<String,dynamic> authData = {
      'email': 'Fer@gmail.com',
      'password': '123',      
    };
    final url = Uri.http( _baseUrl, '/api/login' );
    final resp = await http.post( url, body: authData );         
    final respuesta = LoginRespuesta.fromJson( resp.body );
    if( respuesta.accesToken != null ){      
      await storage.write(key: 'token', value: respuesta.accesToken );
      return null;
    }else{
      return 'Credenciales Incorrectas';
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