import 'package:flutter/material.dart';
import 'package:pets_movil/screens/screens.dart';
import 'package:pets_movil/services/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ )=> PetsService() ),
        ChangeNotifierProvider(create: ( _ ) => AuthService() )
      ],
      child: MyApp(),
      );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login' : ( _ ) => const LoginScreen(),
         'home' : ( _ ) =>  RoutesApp(),
         'register' : ( _ ) => RegisterScreen(),
         'petScreen' : ( _ ) => PetScreen(),
         'checking': ( _ ) => CheckAuthScreen()
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        )
      ),
    );
  }
}