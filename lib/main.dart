import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_movil/blocs/blocs.dart';
import 'package:pets_movil/screens/screens.dart';
import 'package:pets_movil/services/services.dart';
import 'package:provider/provider.dart';

// void main() => runApp( AppState());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await PushNotificationService.initializeApp();
  runApp(AppState());
} 

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ )=> PetsService() ),
        ChangeNotifierProvider(create: ( _ )=> PetsService2() ),
        ChangeNotifierProvider(create: ( _ ) => AuthService2() )
      ],
      child: const MyApp(),
      );
  }
}

class MyApp extends StatelessWidget {  
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context) => GpsBloc() ),
        BlocProvider( create: (context) => LocationBloc() ),
        BlocProvider(create: (context) => MapBloc())        
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login' : ( _ ) => const LoginScreen(),
        'home' : ( _ ) =>   const RoutesApp(),
        'register' : ( _ ) =>  const RegisterScreen(),
        'petScreen' : ( _ ) =>  const PetScreen(),
        'search':  (_) =>  const SearchScreen(),
        'profile': ( _ ) =>  const ProfileScreen(),
        'checking': ( _ ) =>  const CheckAuthScreen()
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
      )
    );
  }
}