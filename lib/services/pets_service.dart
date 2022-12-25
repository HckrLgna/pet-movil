import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pets_movil/models/pets.dart';
import 'package:http/http.dart' as http;

class PetsService extends ChangeNotifier{
  final String _baseUrl = 'flutter-pet-73e62-default-rtdb.firebaseio.com';
  final List<Pet> pets = [];
  late Pet? selectedPet;
  File? newPictureFile;
  bool isLoading = true;
  bool isSaving=false;

  PetsService(){
    this.loadPets();
  }

  Future<List<Pet>> loadPets() async {
    this.isLoading = true;
    notifyListeners();
    final url  = Uri.https(_baseUrl, 'pets.json');
    final resp = await http.get(url);
    final Map<String,dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) {
      final tempPet = Pet.fromMap(value);
      tempPet.id = key;
      this.pets.add(tempPet);
    });
    this.isLoading =false;
    notifyListeners();
    return this.pets;
  }
  //TODO hacer el fetch de producto
  Future saveOrCreateProduct(Pet pet )async{
    isSaving = true;
    notifyListeners();
    if(pet.id == null){
      await this.createPet(pet);
    }else{
      await this.updatePet(pet);
    }
    isSaving = false;
    notifyListeners();
  }
  Future<String> updatePet(Pet pet)async{
    final url = Uri.https(_baseUrl,'pets/${pet.id}.json');
    final resp = await http.put(url, body: pet.toJson());
    final decodeData = resp.body;
    final index=this.pets.indexWhere((element) => element.id == pet.id);
    this.pets[index] = pet;
    return pet.id!;
  }
  Future<String> createPet(Pet pet)async{
    final url = Uri.https(_baseUrl,'pet.json');
    final resp = await http.post(url, body: pet.toJson());
    final decodeData = jsonDecode( resp.body);
    print(decodeData);
    pet.id = decodeData['name'];
    this.pets.add(pet);
    //this.pets.add(value);
    return pet.id!;
  }
  void updateSelectedProductImage(String path){
    selectedPet?.picture = path;
    this.newPictureFile= File.fromUri(Uri(path: path));
    notifyListeners();
  }
  Future<String?> uploadImage ()async{
    if(this.newPictureFile == null ) return null;
    this.isSaving=true;
    notifyListeners();
    final url = Uri.parse('https://api.cloudinary.com/v1_1/duxyfwhfo/image/upload?upload_preset=chqkibwt');
    final imageUploadRequest = http.MultipartRequest('POST',url);
    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if(resp.statusCode != 200 && resp.statusCode!=201){
      print('Algo salio mal');
      print(resp.body);
      return null;
    }
    this.newPictureFile = null;
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
    print(resp.body);
  }
}