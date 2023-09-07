

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_movil/blocs/blocs.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pets_movil/providers/pet_form_provider.dart';
import 'package:pets_movil/screens/screens.dart';
import 'package:pets_movil/services/services.dart';

import 'package:pets_movil/ui/input_decoration.dart';
import 'package:pets_movil/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PetScreen extends StatelessWidget {
  const PetScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final petService = Provider.of<PetsService>(context);
    return ChangeNotifierProvider(
      create: (_) => PetFormProvider(petService.selectedPet!),
      child: _PetsScreenBody(petService: petService),
    );
  }
}

class _PetsScreenBody extends StatelessWidget {

  final PetsService petService;
  const _PetsScreenBody({ Key? key, required this.petService }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final petForm = Provider.of<PetFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                PetImage(url: petService.selectedPet!.picture),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon:
                          const Icon(Icons.arrow_back, size: 40, color: Colors.white),
                    )),
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () async {                       
                        final picker = ImagePicker();
                        final XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.camera, 
                          imageQuality: 100,                          
                        );
                        if ( pickedFile == null ) {
                          // print('no se selecciono nada');
                          return;
                        }                        
                        petService.updateSelectedProductImage( pickedFile.path );
                      },
                      icon: const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white),
                    ))
              ],
            ),
            const _PetForm(),
            const SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: petService.isSaving
            ? null
            : () async {
                //TODO guardar mascota

                if (!petForm.isValidForm()) return;
                // mapBloc.add( OnUnsetAddressEvent() );
                final String? imageUrl = await petService.uploadImage();
                if ( imageUrl != null ) petForm.pet.picture = imageUrl;
                // print(imageUrl);
                await petService.saveOrCreateProduct(petForm.pet);
              },
        child: petService.isSaving
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.save_alt_outlined),
        
      ),
    );
  }
}

class _PetForm extends StatelessWidget {
  const _PetForm({Key? key,}) : super(key: key);   
  
  

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final petForm = Provider.of<PetFormProvider>(context);
    final pet = petForm.pet;
    final controller = TextEditingController( text: pet.location ); 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
            key: petForm.formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                //implementar un formulario completo
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: pet.name,
                  onChanged: (value) => pet.name = value,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El nombre es obligatorio';
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Nombre de la mascota', labelText: 'Nombre'),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  // initialValue: '${pet.reward}',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  onChanged: (value) => {
                    if (double.tryParse(value) == null)
                      {pet.reward = 0}
                    else
                      {pet.reward = int.parse(value)}
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Precio de la recompensa',
                      labelText: 'Recompensa',                      
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async { 
                    FocusManager.instance.primaryFocus?.unfocus();  
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CheckPermissionScreen())).then((value) async {
                                  pet.location = mapBloc.state.address;
                                  controller.text = mapBloc.state.address;                                                                    
                                });                                   
                  },
                  child: TextFormField(                  
                    controller: controller,                                                                                                                        
                    enabled: false,                                                        
                    validator: (value) {
                      if ( value == 'Ubicación de la mascota') {
                        return 'La ubicación es necesaria';
                      }
                      return null;                                                                    
                    },                    
                    decoration: const InputDecoration(
                        disabledBorder: InputBorder.none,
                        hintText: 'Ubicación de la mascota',
                        labelText: 'Ubiación',                        
                        helperStyle: TextStyle(color: Colors.deepPurple),
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        prefixIcon: Icon(Icons.location_on_rounded,
                            color: Colors.deepPurple)
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                SwitchListTile(
                    value: pet.found,
                    title: Text('Disponible'),
                    activeColor: Colors.indigo,
                    onChanged: (value) => petForm.updateAvailability(value)),
                SizedBox(
                  height: 30,
                )
              ],
            )),
      ),
    );

    
  } 
  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
    
}
