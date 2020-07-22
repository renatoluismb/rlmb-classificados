import 'dart:async';
import 'dart:io';

import 'package:cvag/views/Anuncios.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';


class Termos extends StatefulWidget {
  Termos({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TermosState createState() => new _TermosState();
}
final nome = TextEditingController();

class _TermosState extends State<Termos> {

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


  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Declare some constants
    final double myTextSize = 20.0;
    final double myIconSize = 40.0;
    final TextStyle myTextStyle =
    TextStyle(color: Colors.blueAccent, fontSize: myTextSize);

    var column = Column(
      // Makes the cards stretch in horizontal axis
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
//        new Container(
//            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 20.0),
//            child: Row(
//              children: <Widget>[
//                Flexible(
//                    child:
//                    new Text("Termos de Uso", style: TextStyle(color: Colors.grey, fontSize: 24.0)))
//              ],
//            )),
        MyCard(
          // Setup the text
          title: Text(
            "O APLICATIVO",
            style: myTextStyle,
          ),
          // Setup the icon
          subtitle: Text(
            "O app não possui qualquer vínculo com o condômínio Via Enseada. Foi criado para utilização dos moradores e possui o intuito de facilitar a divulgação de produtos e serviços.",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black54, fontSize: 13.0),
          ),
        ),
        MyCard(
          // Setup the text
          title: Text(
            "GRATUIDADE",
            style: myTextStyle,
          ),
          // Setup the icon
          subtitle: Text(
            "O aplicativo é totalmente gratuíto"
                ""
                ""
                ""
                ". Alguns anúncios são exibidos durante o uso do aplicativo. Esses anúncios são aleatórios e geridos pela plataforma de hospedagem, não possuindo qualquer interferência do desenvolvedor.",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black54, fontSize: 13.0),
          ),
        ),
        MyCard(
          // Setup the text
          title: Text(
              "RESPONSABILIDADE",
            style: myTextStyle,
          ),
          // Setup the icon
          subtitle: Text(
            "A utilização do aplicativo é de inteira responsabilidade do usuário. Ao instalar o app, o usuário está concordando com os seguintes itens: \n"
            "- O conteúdo do anúncio é de inteira responsabilidade do usuário anunciante e não passa por qualquer aprovação ou avaliação. Portanto cabe ao usuário o bom senso e a cordialidade na divulgação do seu anúncio. \n"
            "- O aplicativo não faz qualquer intermediação na negociação. O usuário comprador entra em contato diretamente com o usuário vendedor, via telefone ou whatsapp. \n"
            "- Ao se cadastrar, o usuário concorda em ter os dados que foram preenchidos no anúncio, divulgados. \n",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black54, fontSize: 13.0),
          ),
        ),
        MyCard(
          // Setup the text
          title: Text(
            "DESENVOLVEDOR",
            style: myTextStyle,
          ),
          // Setup the icon
          subtitle: Text(
            "O desenvolvedor do aplicativo não possui qualquer interferência na negociação ou no anúncio. Cabe ao usuário fazer a gestão, manutenção e exclusão do seu anúncio.\n"
                "Também, o desenvolvedor do aplicativo, não possui qualquer obrigação de efetuar melhorias e alterações no projeto desenvolvido, cabendo somente a ele a correção de problemas eventualmente encontrados, bem como, melhorias na aplicação.\n",
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.black54, fontSize: 13.0),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("TERMOS DE USO"),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Anuncios()));}
        ),
      ),
      body: Container(
        // Sets the padding in the main container
        padding: const EdgeInsets.only(bottom: 2.0),
        child: SingleChildScrollView(child: column),
      ),
    );
    ;
  }
}


// Create a reusable stateless widget
class MyCard extends StatelessWidget {
  final Widget subtitle;
  final Widget title;

  // Constructor. {} here denote that they are optional values i.e you can use as: MyCard()
  MyCard({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[this.title, this.subtitle],
          ),
        ),
      ),
    );
  }
}