import 'package:cvag/views/Anuncios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

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
        debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Container(
          padding: const EdgeInsets.all(8.0),
          color: Color(0xFF00486b),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                child:Text(
                  "CLASSIFICADOS\n",
                  style: TextStyle(
                    fontSize: 38,
                    fontFamily: 'Baloo',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 52),
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: SvgPicture.asset(
                    'imagens/logo_novo_branco.svg',
                    width: 180.0,
                    height: 220.0,
                    fit: BoxFit.fill,
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