import 'package:flutter/material.dart';
import 'package:pets_movil/models/models.dart';

class PetFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  Pet pet;
  PetFormProvider(this.pet);


  updateAvailability(bool value){
    print(value);
    this.pet.found=value;
    notifyListeners();
  }

  bool isValidForm(){
    print(pet.name);
    print(pet.picture);
    print(pet.reward);
    return formkey.currentState?.validate() ?? false;
  }
}