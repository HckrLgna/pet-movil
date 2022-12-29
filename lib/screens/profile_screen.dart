import 'package:flutter/material.dart';
import 'package:pets_movil/widgets/widgets.dart';
import 'package:pets_movil/screens/screens.dart';


class ProfileScreen extends StatelessWidget {
   
  const ProfileScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          headerAppBar(),
          ListView(
            children: <Widget>[
              
              
            ],
          )
        ],
      ),
      //body: BodyPage(),
      
    );
  }
}


class headerAppBar extends StatelessWidget {
  String ruta=    "assets/profile.jpg";
  String nombre = "Ezequiel Alcantara";
  String correo = "ezeq@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Gradient_back("Profile"),
        Column(
          children: <Widget> [
            dataProfile(ruta,nombre,correo),
            optionList()
          ] 
        )
      ],
    );
  }
}

class Gradient_back extends StatelessWidget {
  String title = "popular";
  Gradient_back(this.title);
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
      child: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 30.0,
        fontFamily: "Lato",
        fontWeight: FontWeight.bold
        
      )
      
      ),
      alignment: Alignment(-0.9, -0.6),
    );
  }
} 

class dataProfile extends StatelessWidget {
  String path ="";
  String name ="";
  String email ="";
  dataProfile(this.path,this.name,this.email);
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

