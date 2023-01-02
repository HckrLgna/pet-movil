import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments ?? 'No data';
    return Scaffold(
      body: Center(
         child: Text( '$args' , style: TextStyle(fontSize: 30)),
      ),
    );
  }
}