
//TOKEN: frvchusSQeikVvvGuHoei2:APA91bFDTz8ft2sP3c7czN1FRlLRvNYVlO3jI70gioCgk5uHKuptHJMBNZh440TLtuC8FCCXsrxew31wd5bUi7lzs5Qc9CXFOjJoqqFJjAtf7VKoNTI3ZOwz_Uord3eA4cjgq1O2ufCM
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:pets_movil/services/services.dart';


class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token; 

  static Future _onBackgroundHandler( RemoteMessage message ) async {    
    NotificationsService.showSnackbar(message.notification?.body ?? 'No data');     
  }

  static Future _onMessageHandler( RemoteMessage message ) async {    
    NotificationsService.showSnackbar(message.notification!.body ?? 'No data');
  }

  static Future _onMessageOpenApp( RemoteMessage message ) async {    
    NotificationsService.showSnackbar(message.notification!.body ?? 'No data');    
  }

  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    await messaging.getInitialMessage();
    // await FirebaseMessaging.instance.subscribeToTopic('all');    

    token = await FirebaseMessaging.instance.getToken();
    print('TOKEN: $token');
    
    // Handler
    FirebaseMessaging.onBackgroundMessage( _onBackgroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onMessageOpenApp );
    
  } 
  
}