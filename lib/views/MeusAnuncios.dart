import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cvag/models/Anuncio.dart';
import 'package:cvag/views/widgets/ItemAnuncio.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MeusAnuncios extends StatefulWidget {
  @override
  _MeusAnunciosState createState() => _MeusAnunciosState();
}

class _MeusAnunciosState extends State<MeusAnuncios> {

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//    keywords: <String>['flutterio', 'beautiful apps', 'games', 'business', 'health'],
//    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[],
  );

  BannerAd myBanner;
  InterstitialAd myInterstitial;
  int clicks = 0;

  void startBanner() {
    var unit = "";
    if (Platform.isIOS) {
      unit =  'ca-app-pub-5071554554343382/6583955267';
    } else if (Platform.isAndroid) {
      unit = 'ca-app-pub-5071554554343382/8951383718';
    }
    myBanner = BannerAd(
      adUnitId: unit,
      size: AdSize.smartBanner,
//      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.opened) {
          // MobileAdEvent.opened
          // MobileAdEvent.clicked
          // MobileAdEvent.closed
          // MobileAdEvent.failedToLoad
          // MobileAdEvent.impression
          // MobileAdEvent.leftApplication
        }
//        print("BannerAd event is $event");
      },
    );
  }

  void displayBanner() {
    if (Platform.isIOS) {
      myBanner
        ..load()
        ..show(
          anchorOffset: 890.0,
          anchorType: AnchorType.bottom,
        );
    } else if (Platform.isAndroid) {
      myBanner
        ..load()
        ..show(
          anchorOffset: 810.0,
          anchorType: AnchorType.bottom,
        );
    }
  }

  final _controller = StreamController<QuerySnapshot>.broadcast();
  String _idUsuarioLogado;

  _recuperaDadosUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;

  }

  Future<Stream<QuerySnapshot>> _adicionarListenerAnuncios() async {

    await _recuperaDadosUsuarioLogado();

    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("meus_anuncios")
        .document( _idUsuarioLogado )
        .collection("anuncios")
        .snapshots();

    stream.listen((dados){
      _controller.add( dados );
    });

  }

  _removerAnuncio(String idAnuncio){

    Firestore db = Firestore.instance;
    db.collection("meus_anuncios")
        .document( _idUsuarioLogado )
        .collection("anuncios")
        .document( idAnuncio )
        .delete().then((_){

      db.collection("anuncios")
          .document(idAnuncio)
          .delete();

    });

  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-5071554554343382~5112157157");
    super.initState();
    Timer(Duration(seconds: 4), () {
      myInterstitial = buildInterstitial()
        ..load()
        ..show();
    });
    _adicionarListenerAnuncios();
  }

  @override
  void dispose() {

    try {

      myBanner?.dispose();
      myInterstitial?.dispose();

    } catch (ex) {
      print(ex);
    }

    super.dispose();
  }

  InterstitialAd buildInterstitial() {
    var unit = "";
    if (Platform.isIOS) {
      unit =  'ca-app-pub-5071554554343382/3385315972';
    } else if (Platform.isAndroid) {
      unit = 'ca-app-pub-5071554554343382/2230116591';
    }
    return InterstitialAd(
        adUnitId: unit,
        targetingInfo: MobileAdTargetingInfo(testDevices: <String>[]),
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            myInterstitial?.show();
          }
          if (event == MobileAdEvent.clicked || event == MobileAdEvent.closed) {
            myInterstitial.dispose();
            clicks = 0;
          }
        });
  }

  @override
  Widget build(BuildContext context) {

    var carregandoDados = Center(
      child: Column(children: <Widget>[
        Text("Carregando anúncios"),
        CircularProgressIndicator()
      ],),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Anúncios"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () =>  Navigator.pushNamed(context, "/anuncios"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        icon: Icon(Icons.add),
        label: Text("Adicionar anúncio"),
        //child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, "/novo-anuncio");
        },
      ),
      body: StreamBuilder(
        stream: _controller.stream,
        builder: (context, snapshot){

          switch( snapshot.connectionState ){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return carregandoDados;
              break;
            case ConnectionState.active:
            case ConnectionState.done:

            //Exibe mensagem de erro
              if(snapshot.hasError)
                return Text("Erro ao carregar os dados!");

              QuerySnapshot querySnapshot = snapshot.data;

              return ListView.builder(
                  itemCount: querySnapshot.documents.length,
                  itemBuilder: (_, indice){

                    List<DocumentSnapshot> anuncios = querySnapshot.documents.toList();
                    DocumentSnapshot documentSnapshot = anuncios[indice];
                    Anuncio anuncio = Anuncio.fromDocumentSnapshot(documentSnapshot);

                    return ItemAnuncio(
                      anuncio: anuncio,
                      onPressedEditar: (){
                        Navigator.pushNamed(
                            context,
                            "/editar-anuncio",
                            arguments: anuncio
                        );
//                        showDialog(
//                            context: context,
//                            builder: (context){
//                              return AlertDialog(
//                                title: Text("Confirmar"),
//                                content: Text("Edição:"),
//                                actions: <Widget>[
//
//                                  FlatButton(
//                                    child: Text(
//                                      "Cancelar",
//                                      style: TextStyle(
//                                          color: Colors.grey
//                                      ),
//                                    ),
//                                    onPressed: (){
//                                      Navigator.of(context).pop();
//                                    },
//                                  ),
//
//                                  FlatButton(
//                                    color: Colors.red,
//                                    child: Text(
//                                      "Remover",
//                                      style: TextStyle(
//                                          color: Colors.white
//
//                                      ),
//                                    ),
//                                    onPressed: (){
//                                      _removerAnuncio( anuncio.id );
//                                      Navigator.of(context).pop();
//                                    },
//                                  ),
//
//
//                                ],
//                              );
//                            }
//                        );
                      },
                      onPressedRemover: (){
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Confirmar", style: TextStyle(
                                  color: Colors.red,
                                      fontWeight: FontWeight.bold
                              ),),
                              content: Text('Deseja realmente excluir o anúncio ' + anuncio.titulo + '?'),
                              actions: <Widget>[

                                FlatButton(
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(
                                        color: Colors.grey
                                    ),
                                  ),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                ),

                                FlatButton(
                                  color: Colors.red,
                                  child: Text(
                                    "Remover",
                                    style: TextStyle(
                                        color: Colors.white

                                    ),
                                  ),
                                  onPressed: (){
                                    _removerAnuncio( anuncio.id );
                                    Navigator.of(context).pop();
                                  },
                                ),


                              ],
                            );
                          }
                      );
                    },

                    );
                  }
              );

          }

          return Container();

        },
      ),
    );
  }
}
