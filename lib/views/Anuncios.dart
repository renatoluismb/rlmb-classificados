import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cvag/main.dart';
import 'package:cvag/models/Anuncio.dart';
import 'package:cvag/util/Configuracoes.dart';
import 'package:cvag/views/widgets/ItemAnuncio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Anuncios extends StatefulWidget {
  @override
  _AnunciosState createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {

 MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[],
  );

  BannerAd myBanner;
  InterstitialAd myInterstitial;
  int clicks = 0;

  void startBanner() {
    myBanner = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.opened) {
          // MobileAdEvent.opened
          // MobileAdEvent.clicked
          // MobileAdEvent.closed
          // MobileAdEvent.failedToLoad
          // MobileAdEvent.impression
          // MobileAdEvent.leftApplication
        }
        print("BannerAd event is $event");
      },
    );
  }

  void displayBanner() {
    myBanner
      ..load()
      ..show(
        anchorOffset: 105.0,
        anchorType: AnchorType.bottom,
      );
  }

  FirebaseUser usuarioLogado;

  int _currentTabIndex = 0;

  List<String> itensMenu = [];
  List<DropdownMenuItem<String>> _listaItensDropCategorias;
  List<DropdownMenuItem<String>> _listaItensDropEstados;

  final _controler = StreamController<QuerySnapshot>.broadcast();

  String _itemSelecionadoEstado;
  String _itemSelecionadoCategoria;

  _escolhaMenuItem(String itemEscolhido){

    switch( itemEscolhido ){

      case "Meus anúncios" :
        Navigator.pushNamed(context, "/meus-anuncios");
        break;
      case "Entrar / Cadastrar" :
        Navigator.pushNamed(context, "/login");
        break;
      case "Deslogar" :
        _deslogarUsuario();
        break;

    }

  }

  _deslogarUsuario() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushNamed(context, "/login");

  }

  Future _verificarUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    usuarioLogado = await auth.currentUser();

    if( usuarioLogado == null ){
      itensMenu = [
        "Entrar / Cadastrar"
      ];
    }else{
      itensMenu = [
        "Meus anúncios", "Deslogar"
      ];
    }

  }

  _carregarItensDropdown(){

    //Categorias
    _listaItensDropCategorias = Configuracoes.getCategorias();

    //Estados
    _listaItensDropEstados = Configuracoes.getEstados();

  }

  Future<Stream<QuerySnapshot>> _adicionarListenerAnuncios() async {
    print('caiu aqui');

    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("anuncios")
        .snapshots();

    stream.listen((dados){
      _controler.add(dados);
    });

  }

  Future<Stream<QuerySnapshot>> _filtrarAnuncios() async {

    Firestore db = Firestore.instance;
    Query query = db.collection("anuncios");

    if( _itemSelecionadoEstado != null ){
      query = query.where("estado", isEqualTo: _itemSelecionadoEstado);
    }
    if( _itemSelecionadoCategoria != null ){
      query = query.where("categoria", isEqualTo: _itemSelecionadoCategoria);
    }

    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((dados){
      _controler.add(dados);
    });

  }

  @override
  void initState() {

    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-5071554554343382~5112157157");
    super.initState();


//    startBanner();
//    displayBanner();

    myInterstitial = buildInterstitial()
      ..load()
      ..show();


    _carregarItensDropdown();
    _verificarUsuarioLogado();
    _adicionarListenerAnuncios();

  }

 InterstitialAd buildInterstitial() {
   return InterstitialAd(
       adUnitId: "ca-app-pub-5071554554343382/3385315972",
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
  void dispose() {
    myBanner?.dispose();
    myInterstitial?.dispose();
    super.dispose();
  }

  _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
         Navigator.popAndPushNamed(context, '/anuncios');
        break;
      case 1:
        if (usuarioLogado != null) {
          Navigator.popAndPushNamed(context, '/meus-anuncios');
        } else {
          mostraMsg('Usuário não localizado! Faça o seu login, ou cadastre-se!');
        }
        break;
        case 2:
          Navigator.popAndPushNamed(context, "/login");
        break;
    }
    setState(() {
      _currentTabIndex = tabIndex;
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
        title: Text("Classificados - Via Enseada"),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){
              return itensMenu.map((String item){
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Início'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.chrome_reader_mode),
            title: new Text('Meus Anúncios'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Entrar/Cadastrar')
          )
        ],
        onTap: _onTap,
      ),

//      drawer: Drawer(
//        // Add a ListView to the drawer. This ensures the user can scroll
//        // through the options in the drawer if there isn't enough vertical
//        // space to fit everything.
//        child: ListView(
//          // Important: Remove any padding from the ListView.
//          padding: EdgeInsets.zero,
//          children: <Widget>[
//            DrawerHeader(
//              child: Text('Nome do usuário logado',
//                style: TextStyle(
//                    color: Colors.white
//                ),),
//              decoration: BoxDecoration(
//                color: Colors.teal,
//              ),
//            ),
//            ListTile(
//              leading: Icon(Icons.home),
//              title: Text('Início'),
////              onTap: () {
////                Navigator.popAndPushNamed(context, '/dashboard');
////              },
//              enabled: true,
//
//              onTap: () {
//                Navigator.pop(context);
//              },
//            ),
//            ListTile(
//              leading: Icon(Icons.contact_mail),
//              title: Text('Meus Anúncios'),
//              onTap: () {
//                Navigator.pushNamed(context, "/meus-anuncios");
//              },
//            ),
//          ],
//        ),
//      ),
      body: Container(
    child: RefreshIndicator(
        child: Column(children: <Widget>[

          Row(children: <Widget>[

//            Expanded(
//              child: DropdownButtonHideUnderline(
//                  child: Center(
//                    child: DropdownButton(
//                      iconEnabledColor: temaPadrao.primaryColor,
//                      value: _itemSelecionadoEstado,
//                      items: _listaItensDropEstados,
//                      style: TextStyle(
//                        fontSize: 22,
//                        color: Colors.black
//                      ),
//                      onChanged: (estado){
//                        setState(() {
//                          _itemSelecionadoEstado = estado;
//                          _filtrarAnuncios();
//                        });
//                      },
//                    ),
//                  )
//              ),
//            ),

//            Container(
//              color: Colors.grey[200],
//              width: 2,
//              height: 60,
//            ),

            Expanded(
              child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButton(
                      iconEnabledColor: Colors.teal,
                      value: _itemSelecionadoCategoria,
                      items: _listaItensDropCategorias,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),
                      onChanged: (categoria){
                        setState(() {
                          _itemSelecionadoCategoria = categoria;
                          _filtrarAnuncios();
                        });
                      },
                    ),
                  )
              ),
            )



          ],),

          StreamBuilder(
            stream: _controler.stream,
            builder: (context, snapshot){
              switch( snapshot.connectionState ){
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return carregandoDados;
                  break;
                case ConnectionState.active:
                case ConnectionState.done:

                  QuerySnapshot querySnapshot = snapshot.data;

                  if( querySnapshot.documents.length == 0 ){
                    return Container(
                      padding: EdgeInsets.all(25),
                      child: Text("Nenhum anúncio! :( ", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                        itemCount: querySnapshot.documents.length,
                        itemBuilder: (_, indice){

                          List<DocumentSnapshot> anuncios = querySnapshot.documents.toList();
                          DocumentSnapshot documentSnapshot = anuncios[indice];
                          Anuncio anuncio = Anuncio.fromDocumentSnapshot(documentSnapshot);

                          return ItemAnuncio(
                            anuncio: anuncio,
                            onTapItem: (){
                              Navigator.pushNamed(
                                  context,
                                  "/detalhes-anuncio",
                                  arguments: anuncio
                              );
                            },
                          );

                        }
                    ),
                  );

              }
              return Container();
            },
          )

        ]
        ),onRefresh: _adicionarListenerAnuncios),
      ),
    );
  }
}

void mostraMsg(msg) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5);
}

