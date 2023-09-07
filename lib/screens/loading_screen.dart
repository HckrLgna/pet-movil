import 'package:flutter/material.dart';
import 'package:pets_movil/services/services.dart';

import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
   
  const LoadingScreen({Key? key}) : super(key: key);  
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService2>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mascotas'),
        leading: IconButton(
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          }, 
          icon: const Icon(Icons.login_outlined)
          ),
      ),
      body: const Center(
        child: CircularProgressIndicator(
          color: Colors.indigo,
        )
      ),
    );
  }
}