import 'package:flutter/material.dart';
import 'package:pets_movil/ui/input_decoration.dart';
import 'package:pets_movil/widgets/widgets.dart';

class PetScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                PetImage(),
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
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre de la mascota', 
                  labelText: 'Nombre'
                  ),
              ),TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Precio de la recompensa', 
                  labelText: 'Recompensa'
                  ),
              ),
              SizedBox(height: 30,),
              
              SwitchListTile(
                value: true, 
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