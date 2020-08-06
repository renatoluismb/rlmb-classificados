import 'dart:io';

import 'package:cvag/views/Anuncios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_appstore/open_appstore.dart';


class Apps extends StatefulWidget {
  Apps({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppsState createState() => new _AppsState();
}
var plataforma;

//void main() {
//  // Get the operating system as a string.
//  String os = Platform.operatingSystem;
//  // Or, use a predicate getter.
//  if (Platform.isIOS) {
//    plataforma = 'IOS';
//  } else {
//    plataforma = 'Android';
//  }
//  print('>>>>>');
//  print(plataforma);
//}

final nome = TextEditingController();

class _AppsState extends State<Apps> {

  String urlLocalizacaoIOS = '';
  String urlLocalizacaoAndroid = '';
  String urlQuizIOS = '';
  String urlQuizAndroid = '';
  String urlReceitasIOS = '';
  String urlReceitasAndroid = '';

  @override
  initState() {
    super.initState();

    if (Platform.isIOS) {
      plataforma = 'IOS';
    } else {
      plataforma = 'Android';
    }
    print('>>>>>');
    print(plataforma);
  }

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              backgroundColor: Color(0xFF00486b),
              title: Text("Outros Aplicativos"),
              leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios),
                  onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Anuncios()));}
              ),
            ),
              body: SingleChildScrollView(

                  child: Column(
                  children: <Widget>[
              Container(
//              padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
              height: 260,
              width: double.maxFinite,
              child: Card(
                color: Colors.white70.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                ),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Stack(children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[app1()],
                                  ),
                                  logoApp('localizacao'),
                                ],
                              )),
                        ],
                      ),
                    ),

                  ]),
                ),
              ),
            ),
                  Container(
//              padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
              height: 260,
              width: double.maxFinite,
              child: Card(
                color: Colors.white70.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                ),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Stack(children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[app2()],
                                  ),
                                  logoApp('receitas'),
                                ],
                              )),
                        ],
                      ),
                    ),

                  ]),
                ),
              ),
            ),
              Container(
//                padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                height: 260,
                width: double.maxFinite,
                child: Card(
                  color: Colors.white70.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(24.0),
                    ),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Stack(children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(left: 10, top: 5),
                                child: Column(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[app3()],
                                    ),
                                    logoApp('quiz'),
                                  ],
                                )),
                          ],
                        ),
                      ),

                    ]),
                  ),
                ),
              ),
    ]))));
  }
  Widget logoApp(appId) {
    if (plataforma == 'IOS' ) {
      return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child:  Align(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Image.asset('assets/apple.png',
                    width: 160,
                    height: 48,
                    fit:BoxFit.fill
                ),
                onTap: (){
                  if (appId == 'localizacao') {
                    print(appId);
                    OpenAppstore.launch(androidAppId: 'com.rlmb.localizacao', iOSAppId: '1524516010');
                  }
                  if (appId == 'receitas') {
                    OpenAppstore.launch(androidAppId: 'com.rlmb.receitas', iOSAppId: '1525901510');
                  }
                  if (appId == 'quiz') {
                    OpenAppstore.launch(androidAppId: 'com.rlmb.quiz', iOSAppId: '1524698831');
                  }
                },
              )
          )
      ); }
    else {
      return Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child:  Align(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Image.asset('assets/google.png',
                    width: 160,
                    height: 48,
                    fit:BoxFit.fill
                ),
                onTap: (){
                  if (appId == 'localizacao') {
                    print(appId);
                    OpenAppstore.launch(androidAppId: 'com.rlmb.localizacao', iOSAppId: '1524516010');
                  }
                  if (appId == 'receitas') {
                    OpenAppstore.launch(androidAppId: 'com.rlmb.receitas', iOSAppId: '1525901510');
                  }
                  if (appId == 'quiz') {
                    OpenAppstore.launch(androidAppId: 'com.rlmb.quiz', iOSAppId: '1524698831');
                  }
                },
              )
          )
      );
    }
  }

//  Widget logoGoogle() {
//    return Align(
//      alignment: Alignment.topRight,
//        child: GestureDetector(
//      child: Image.asset('assets/google.png',
//        width: 160,
//        height: 65,
//        fit:BoxFit.fill
//    ),
//          onTap: (){
//            print('google');
//          },
//    )
//    );
//  }
  Widget app1() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: '\n   Central de Localização',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 28,
                    fontWeight: FontWeight.bold
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '\n -   Sua nova plataforma de localização - \n',
                      style: TextStyle(
                          color: Colors.green,
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'Encontre tudo ao seu redor. Vários estabelecimentos...\n',
                      style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'Busca direta, busca por categoria...Tudo ao seu alcance!\n\n  ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  TextSpan(

                      text: '                          Baixe agora mesmo!!!!',
                      style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget app2() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: '\n              Receitas',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '\n- As mais variadas receitas. Ao seu alcance -\n',
                      style: TextStyle(
                          color: Colors.green,
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'Consulte receitas enviadas de todo o Brasil!\n',
                      style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'Cadastre suas receitas e avalie as que mais gostou!\n\n  ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: '                          Baixe agora mesmo!!!!',
                      style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget app3() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: '\n                QUIZ!',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '\n- Desafio lançado. Corra contra o tempo -\n',
                      style: TextStyle(
                          color: Colors.green,
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: '12 perguntas. 15 segundos para cada.\n',
                      style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'Agilidade e conhecimento. Em um único lugar!\n\n  ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: '                          Baixe agora mesmo!!!!',
                      style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}