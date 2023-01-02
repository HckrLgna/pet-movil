//SHA1 3A:D6:73:49:A4:F2:E0:39:F3:A7:26:C1:54:A9:58:21:04:C2:89:71
//
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler( RemoteMessage message ) async {
     //print( 'onBackground Handler ${ message.messageId }');
    print( message.data );
    _messageStream.add( message.data['product'] ?? 'No data' );
  }

  static Future _onMessageHandler( RemoteMessage message ) async {
     //print( 'onMessage Handler ${ message.messageId }');
    print( message.data );
    _messageStream.add( message.data['product'] ?? 'No data' );
  }

  static Future _onMessageOpenApp( RemoteMessage message ) async {
    //print( 'onMessageOpenApp Handler ${ message.messageId }');
    print( message.data );
    _messageStream.add( message.data['product'] ?? 'No data' );
  }



  static Future initializeApp() async {

    // Push Notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage( _backgroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onMessageOpenApp );

    // Local Notifications
  }
    static closeStreams() {
    _messageStream.close();
  }
}
