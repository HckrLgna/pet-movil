import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_movil/blocs/blocs.dart';
import 'package:pets_movil/screens/screens.dart';

class RoutesApp extends StatefulWidget {
  const RoutesApp({Key? key}) : super(key: key);

  @override
  State<RoutesApp> createState() => _RoutesAppState();
}

class _RoutesAppState extends State<RoutesApp> {
  int indexTap=0;
  final List<Widget> widgetsChildern = [
      const HomeScreen(),
      const SearchScreen(),
      const ReconigtionScreen(),
      const ProfileScreen()
  ];  
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    void onTapTapped(int index){
      setState(() {
        if ( index == 0 ){
          mapBloc.add( OnHideMarkers() );          
        }
        if ( index == 1 ){
          mapBloc.add( OnShowMarkers() );
          mapBloc.showMarcadores();
        }        
        indexTap = index;
      });
    }

    return Scaffold(
      body: widgetsChildern[indexTap],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.indigo,
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
                label: 'search',                
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.image_search),
                label: 'reconigtion'
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