import 'package:cvag/splash.dart';
import 'package:flutter/material.dart';
import 'package:cvag/RouteGenerator.dart';
import 'package:cvag/views/Anuncios.dart';
import 'package:cvag/views/Login.dart';

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

