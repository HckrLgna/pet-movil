import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pets_movil/models/pets.dart';
import 'package:http/http.dart' as http;

class PetsService extends ChangeNotifier{
  final String _baseUrl = 'flutter-pet-73e62-default-rtdb.firebaseio.com';
  final List<Pet> pets = [];
  late Pet? selectedPet;
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

    }else{
      await this.updatePet(pet);
    }
    isSaving = false;
    notifyListeners();
  }
  Future<String?> updatePet(Pet pet)async{
    final url = Uri.https(_baseUrl,'pets/${pet.id}.json');
    final resp = await http.put(url, body: pet.toJson());
    final decodeData = resp.body;
    print(decodeData);
    
    return pet.id;
  }
  
}