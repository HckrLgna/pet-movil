import 'package:flutter/material.dart';
import 'package:pets_movil/models/models.dart';
import 'package:pets_movil/screens/screens.dart';
import 'package:pets_movil/services/services.dart';
import 'package:provider/provider.dart';



class CircleButton extends StatelessWidget {
  bool mini;
  IconData icon;
  double iconSize;
  Color color;

  CircleButton(this.mini, this.icon, this.iconSize, this.color, {super.key});

  @override
  Widget build(BuildContext context) {  
    final petsService = Provider.of<PetsService>(context);  
    return Expanded(
      child: FloatingActionButton(
        backgroundColor: color,
        mini:mini,
        onPressed: () { 
          petsService.selectedPet = Pet(
              found: true,
              name: '',
              reward: 0,
              location: 'Ubicación de la mascota',
          );
          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const RegistrarMascotaScreen()));
        },
        child: Icon(
          icon,
          size: iconSize,
          color: const Color(0xFF4268D3),
        ),
      )
    );
  }
}