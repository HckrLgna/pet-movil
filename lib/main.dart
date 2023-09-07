import 'package:flutter/material.dart';
import 'package:pets_movil/screens/screens.dart';
import 'package:pets_movil/services/services.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await PushNotificationService.initializeApp();
  runApp(AppState());
} 

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>(); 
  @override
  void initState() {
    super.initState();
    PushNotificationService.messagesStream.listen((message) {
      navigatorKey.currentState?.pushNamed('search', arguments: message);
      print('My app:$message');
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      navigatorKey: navigatorKey,
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