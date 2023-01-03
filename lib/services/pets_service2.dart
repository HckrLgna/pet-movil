import 'dart:convert';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pets_movil/models/models.dart';
import 'package:http/http.dart' as http;

class PetsService2 extends ChangeNotifier{
  final String _baseUrl = '54.87.50.127';
  final List<Mascota> pets = [];
  Mascota? selectedPet;
  // final storage = const FlutterSecureStorage();

  File? newPictureFile;
  bool isLoading = true;
  bool isSaving=false;

  PetsService2(){
    loadPets();
  }

  Future<void> loadPets() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http( _baseUrl, '/api/mascotas' );
    final resp = await http.get( url );    
    final List<dynamic> petsMap = jsonDecode( resp.body );    
    for ( var i = 0 ; i < petsMap.length ; i++ ) {
      var temp = Mascota.fromMap( petsMap[i] );
      pets.add( temp );
    }    
    isLoading =false;
    notifyListeners();      
  }
  
  // Future saveOrCreateProduct(Pet pet )async{
  //   isSaving = true;
  //   notifyListeners();
  //   if(pet.id == null){
  //     await this.createPet(pet);
  //   }else{
  //     await this.updatePet(pet);
  //   }
  //   isSaving = false;
  //   notifyListeners();
  // }
  // Future<String> updatePet(Pet pet)async{
  //   final url = Uri.https(_baseUrl,'pets/${pet.id}.json');
  //   final resp = await http.put(url, body: pet.toJson());
  //   final decodeData = resp.body;
  //   final index=this.pets.indexWhere((element) => element.id == pet.id);
  //   this.pets[index] = pet;
  //   return pet.id!;
  // }
  // Future<String> createPet(Pet pet)async{
  //   final url = Uri.https(_baseUrl,'pets.json',
  //     {'auth': await storage.read(key: 'token') ?? ''});
  //   final resp = await http.post(url, body: pet.toJson());
  //   final decodeData = jsonDecode( resp.body);
  //   print(decodeData);
  //   pet.id = decodeData['name'];
  //   this.pets.add(pet);
    
  //   return pet.id!;
  // }
  void updateSelectedProductImage(String path){
    selectedPet?.imagen = path;
    newPictureFile= File.fromUri(Uri(path: path));
    notifyListeners();
  }
  Future<String?> uploadImage ()async{
    if( newPictureFile == null ) return null;
    isSaving=true;
    notifyListeners();
    final url = Uri.parse('https://api.cloudinary.com/v1_1/duxyfwhfo/image/upload?upload_preset=chqkibwt');
    final imageUploadRequest = http.MultipartRequest('POST',url);
    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if(resp.statusCode != 200 && resp.statusCode!=201){      
      return null;
    }
    newPictureFile = null;
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
    
  }
}