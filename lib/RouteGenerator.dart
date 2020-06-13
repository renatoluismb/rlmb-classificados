
import 'package:cvag/termos.dart';
import 'package:cvag/termos_aceite.dart';
import 'package:cvag/views/EditarAnuncio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cvag/views/Anuncios.dart';
import 'package:cvag/views/DetalhesAnuncio.dart';
import 'package:cvag/views/Login.dart';
import 'package:cvag/views/MeusAnuncios.dart';
import 'package:cvag/views/NovoAnuncio.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch( settings.name ){
      case "/" :
        return MaterialPageRoute(
          builder: (_) => Anuncios()
        );
      case "/login" :
        return MaterialPageRoute(
            builder: (_) => Login()
        );
      case "/meus-anuncios" :
        return MaterialPageRoute(
            builder: (_) => MeusAnuncios()
        );
      case "/novo-anuncio" :
        return MaterialPageRoute(
            builder: (_) => NovoAnuncio()
        );
      case "/editar-anuncio" :
        return MaterialPageRoute(
            builder: (_) => EditarAnuncio(args)
        );
      case "/detalhes-anuncio" :
        return MaterialPageRoute(
            builder: (_) => DetalhesAnuncio(args)
        );
      case "/termos" :
        return MaterialPageRoute(
            builder: (_) => Termos()
        );
      case "/termos-aceite" :
        return MaterialPageRoute(
            builder: (_) => TermosAceite(args)
        );
      default:
        _erroRota();
    }

  }

  static Route<dynamic> _erroRota(){

    return MaterialPageRoute(
      builder: (_){
        return Scaffold(
          appBar: AppBar(
            title: Text("Tela não encontrada!"),
          ),
          body: Center(
            child: Text("Tela não encontrada!"),
          ),
        );
      }
    );

  }

}