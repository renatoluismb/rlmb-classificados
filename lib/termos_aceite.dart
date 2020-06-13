import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cvag/models/Usuario.dart';
import 'package:cvag/views/Anuncios.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cvag/main.dart';
import 'package:cvag/models/Anuncio.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class TermosAceite extends StatefulWidget {

  Usuario usuario;
  TermosAceite(this.usuario);

  @override
  _TermosAceiteState createState() => _TermosAceiteState();
}

class _TermosAceiteState extends State<TermosAceite> {

  Usuario _usuario;

  @override
  void initState() {
    super.initState();

    _usuario = widget.usuario;

    print(_usuario.email);

  }

  _cadastrarUsuario(){

    print(_usuario.email);

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
        email: _usuario.email,
        password: _usuario.senha
    ).then((firebaseUser){

      mostraMsgSucesso('Usuário cadastrado com sucesso!');

      //redireciona para tela principal
      Navigator.pushReplacementNamed(context, "/anuncios");

    });

  }

  @override
  Widget build(BuildContext context) {

    // Declare some constants
    final double myTextSize = 16.0;
    final double myIconSize = 36.0;
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
            "O aplicativo é totalmente gratuíto tanto para plataformas Android como IOS. Alguns anúncios são exibidos durante o uso do aplicativo. Esses anúncios são aleatórios e geridos pela plataforma de hospedagem, não possuindo qualquer interferência do desenvolvedor.",
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //store btn
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green)),
              color: Colors.green,
              child: new Text('Aceitar e Cadastrar', style: TextStyle(color: Colors.white, fontSize: 13.0)),
              onPressed: () {
                _cadastrarUsuario();
              },),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)),
              color: Colors.red,
              child: new Text('Voltar', style: TextStyle(color: Colors.white, fontSize: 13.0)),
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },),
          ]
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

void mostraMsgSucesso(msg) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5);
}
