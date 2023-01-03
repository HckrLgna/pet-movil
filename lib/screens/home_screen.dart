import 'package:flutter/material.dart';
import 'package:pets_movil/models/models.dart';
import 'package:pets_movil/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:pets_movil/services/services.dart';
import 'package:pets_movil/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final petsService = Provider.of<PetsService>(context);
    final authService = Provider.of<AuthService2>(context,listen: false);
    if (petsService.isLoading) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perros Perdidos'),     
        leading: IconButton(
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          }, 
          icon: const Icon(Icons.login_outlined)
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
          child: const Icon(Icons.add),
          onPressed: () {
            petsService.selectedPet = Pet(
              found: true,
              name: '',
              reward: 0,
              location: 'Ubicación de la mascota',
              );
            Navigator.pushNamed(context, 'petScreen');
          },
          ),
    );
  }
}