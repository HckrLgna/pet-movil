import 'package:flutter/material.dart';
import 'package:pets_movil/models/models.dart';
import 'package:pets_movil/screens/screens.dart';
import 'package:pets_movil/services/pets_service.dart';
import 'package:provider/provider.dart';

import 'package:pets_movil/services/services.dart';
import 'package:pets_movil/widgets/widgets.dart';



class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final petsService = Provider.of<PetsService>(context);
    final authService = Provider.of<AuthService>(context,listen: false);
    if (petsService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: Text('Perros Perdidos'),
        leading: IconButton(
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          }, 
          icon: Icon(Icons.login_outlined)
          ),
      ),
      body: ListView.builder(
        itemCount: petsService.pets.length,
        itemBuilder: (BuildContext context, index ) => GestureDetector(
          onTap: () {
            petsService.selectedPet = petsService.pets[index].copy();
            Navigator.pushNamed(context, 'petScreen');
          },
          child: PetCard(
            pet: petsService.pets[index],
          )
          )
      
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            petsService.selectedPet = new Pet(
              found: true,
              name: ''
              );
            Navigator.pushNamed(context, 'petScreen');
          },
          ),
    );
  }
}