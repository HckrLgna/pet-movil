import 'package:flutter/material.dart';
import 'package:pets_movil/models/models.dart';

class RegisterPetProvider extends ChangeNotifier{

  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  Pet pet;
  RegisterPetProvider(this.pet);


  updateAvailability(bool value){
    // print(value);
    this.pet.found=value;
    notifyListeners();
  }

  bool isValidForm(){
    // print('VALORES DEL FORMULARIO');
    // print(pet.picture);
    // print(pet.name);
    // print(pet.reward);
    // print(pet.location);
    return formkey2.currentState?.validate() ?? false;
  }
}
