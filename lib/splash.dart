import 'package:cvag/views/Anuncios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 4)).then((_){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Anuncios()));
    });
  }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: new Scaffold(
        body: new Container(
          padding: const EdgeInsets.all(8.0),
          color: Color(0xFF00486b),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200.0,
                width: 390.0,
                decoration: new BoxDecoration(
                    image: DecorationImage(
                        image: new AssetImage('imagens/logo.png'),
//                        fit: BoxFit.fitWidth
                    ),
//                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child:Text('Classificados - Via Enseada',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Aleo',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}