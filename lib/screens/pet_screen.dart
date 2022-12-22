import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pets_movil/providers/pet_form_provider.dart';
import 'package:pets_movil/services/pets_service.dart';
import 'package:pets_movil/ui/input_decoration.dart';
import 'package:pets_movil/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PetScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final petService = Provider.of<PetsService>(context);
    return ChangeNotifierProvider(
      create: ( _ )=> PetFormProvider(petService.selectedPet!),
      child: _PetsScreenBody(petService: petService),
    );

    //return _PetsScreenBody(petService: petService);
  }
}

class _PetsScreenBody extends StatelessWidget {
  const _PetsScreenBody({
    Key? key,
    required this.petService,
  }) : super(key: key);

  final PetsService petService;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                PetImage(url: petService.selectedPet!.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed:() => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back, size: 40, color: Colors.white),
                    )
                  ),
                  Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed:() {
                      //TODO camara o galeria
                    },
                    icon: Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white),
                    )
                  )
              ],
            ),
            _PetForm(),
            SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_alt_outlined),
        onPressed: () {
          //TODO guardar mascota
        },
        ),
    );
  }
}

class _PetForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final petForm = Provider.of<PetFormProvider>(context);
    final pet = petForm.pet;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [ 
              //implementar un formulario completo
              SizedBox(height: 10,),
              TextFormField(
                initialValue: pet.name,
                onChanged: (value) => pet.name = value,
                validator: (value) {
                  if (value == null || value.length <1)
                  return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre de la mascota', 
                  labelText: 'Nombre'
                  ),
              ),TextFormField(
                keyboardType: TextInputType.number,
                initialValue: '${pet.reward}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) => {
                  if(double.tryParse(value)==null){
                    pet.reward = 0
                  }else{
                    pet.reward = int.parse(value)
                  }
                },
              
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Precio de la recompensa', 
                  labelText: 'Recompensa'
                  ),
              ),
              SizedBox(height: 30,),
              
              SwitchListTile(
                value: pet.found, 
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: (value) {
                  
                },
              ),
              SizedBox(height: 30,)
            ],
          )
          ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: Offset(0, 5),
        blurRadius: 5
      )
    ] 
  );
}