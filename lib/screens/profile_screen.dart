import 'package:flutter/material.dart';
import 'package:pets_movil/screens/screens.dart';
import 'package:pets_movil/services/services.dart';
import 'package:pets_movil/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  
  const ProfileScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final petsService = Provider.of<PetsService>(context);    
    if (petsService.isLoading) return const LoadingScreen();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(        
              children: const [
                HeaderAppBar(),                 
              ],
            ),                   
            PetCard( pet: petsService.pets[0] ),
            PetCard( pet: petsService.pets[1] ),
            PetCard( pet: petsService.pets[2] ),
          ],
          // child: Stack(        
          //   children: const [
          //     HeaderAppBar(),          
              // ListView.builder(
              //   itemCount: petsService.pets.length,
              //   itemBuilder: (BuildContext context, index ) => GestureDetector(
              //     onTap: () {
              //       petsService.selectedPet = petsService.pets[index].copy();
              //       Navigator.pushNamed(context, 'petScreen');
              //     },
              //     child: PetCard(
              //       pet: petsService.pets[index],
              //     )
              //     )
              // ),          
            // ],
          // ),
        ),
      ),
      //body: BodyPage(),            
    );
  }
}


class HeaderAppBar extends StatelessWidget {

  const HeaderAppBar({Key? key}) : super(key: key);

  final String ruta=    "assets/profile.jpg";
  final String nombre = "Ezequiel Alcantara";
  final String correo = "ezeq@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const GradientBack("Profile"),
        Column(
          children: <Widget> [
            DataProfile( path: ruta, name: nombre, email: correo ),
            const optionList()
          ] 
        )
      ],
    );
  }
}

class GradientBack extends StatelessWidget {
  final String title;
  const GradientBack( this.title, {Key? key}) : super(key: key);
  // Gradient_back(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(      
      height: 300.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors:[
            Color(0xff4268d3),
            Color(0xff584cd1)
          ],
          begin: FractionalOffset(0.2, 0.0),
          end: FractionalOffset(1.0, 0.6),
          stops: [0.0, 0.6],
          tileMode: TileMode.clamp
        )
      ),
      alignment: const Alignment(-0.9, -0.6),
      child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30.0,
        fontFamily: "Lato",
        fontWeight: FontWeight.bold        
      )      
      ),
    );
  }
} 

class DataProfile extends StatelessWidget {
  final String path;
  final String name;
  final String email;
  const DataProfile({Key? key, required this.path, required this.name, required this.email}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final photo = Container(
      margin: const EdgeInsets.only(
        top: 90.0,
        left: 20.0,
        bottom: 0.0
      ),
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(path)
          )
      ),
      
    );
    final userNAme = Container(
      margin: const EdgeInsets.only(
        top: 90.0,
        left: 20.0
      ),
      child: Text(
        name,
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontSize: 19.0,
          fontWeight: FontWeight.normal,
          color: Colors.white54
        ),
      ),
    );
    final correo = Container(
      margin: const EdgeInsets.only(
        top: 2.0,
      ),
      child: Text(
        email,
        style: const TextStyle(
          color: Colors.white24
        ),
      ),
    );
    final datos = Column(
      children: <Widget>[
        userNAme,
        correo
      ],
    );
    return Row(
      children: <Widget>[
        photo,
        datos,
      ],
    );
  }
}

