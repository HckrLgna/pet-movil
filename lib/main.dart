import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_movil/blocs/blocs.dart';
import 'package:pets_movil/screens/screens.dart';
import 'package:pets_movil/services/services.dart';
import 'package:provider/provider.dart';

// void main() => runApp( AppState());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(const AppState());
}
class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ )=> PetsService() ),
        ChangeNotifierProvider(create: ( _ ) => AuthService() )
      ],
      child: const MyApp(),
      );
  }
}

class MyApp extends StatelessWidget {  
  const MyApp({Key? key}) : super(key: key);
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
         'search':  (_) => SearchScreen(),
         'profile': ( _ ) => ProfileScreen(),
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