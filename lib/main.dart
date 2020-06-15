import 'package:cvag/splash.dart';
import 'package:flutter/material.dart';
import 'package:cvag/RouteGenerator.dart';
import 'package:cvag/views/Anuncios.dart';
import 'package:cvag/views/Login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xFF00486b),
  accentColor: Colors.blueGrey
);

void main() => runApp(MaterialApp(
  title: "Compre e Vendas Águas Claras",
  home: Splash(),
  theme: temaPadrao,
  initialRoute: "/splash",
  routes: <String, WidgetBuilder>{
    '/splash': (BuildContext context) => Splash(),
    '/anuncios': (BuildContext context) => Anuncios(),
  },
  onGenerateRoute: RouteGenerator.generateRoute,
  debugShowCheckedModeBanner: false,
));

//class PushNotificationsManager {
//
//  PushNotificationsManager._();
//
//  factory PushNotificationsManager() => _instance;
//
//  static final PushNotificationsManager _instance = PushNotificationsManager._();
//
//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//  bool _initialized = false;
//
//  Future<void> init() async {
//    if (!_initialized) {
//      // For iOS request permission first.
//      _firebaseMessaging.requestNotificationPermissions();
//      _firebaseMessaging.configure();
//
//      // For testing purposes print the Firebase Messaging token
//      String token = await _firebaseMessaging.getToken();
//      print("FirebaseMessaging token: $token");
//
//      _initialized = true;
//    }
//  }
//}