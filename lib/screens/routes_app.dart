import 'package:flutter/material.dart';
import 'package:pets_movil/screens/screens.dart';

class RoutesApp extends StatefulWidget {
  const RoutesApp({super.key});

  @override
  State<RoutesApp> createState() => _RoutesAppState();
}

class _RoutesAppState extends State<RoutesApp> {
  int indexTap=0;
  final List<Widget> widgetsChildern = [
      HomeScreen(),
      SearchScreen(),
      ProfileScreen()

  ];
  void onTapTapped(int index){
    setState(() {
      indexTap=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetsChildern[indexTap],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.purple
        ),
        child: BottomNavigationBar(
          currentIndex: indexTap,
          onTap: onTapTapped,
          items:  const [
              BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'search'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.accessibility),
                label: 'profile'
              ),
          ]
          ),        
      ),
    );
  }
}