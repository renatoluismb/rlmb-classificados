import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cvag/main.dart';
import 'package:cvag/models/Anuncio.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalhesAnuncio extends StatefulWidget {

  Anuncio anuncio;
  DetalhesAnuncio(this.anuncio);

  @override
  _DetalhesAnuncioState createState() => _DetalhesAnuncioState();
}

class _DetalhesAnuncioState extends State<DetalhesAnuncio> {

  PermissionStatus _status;

  Anuncio _anuncio;

  List<Widget> _getListaImagens(){

    List<String> listaUrlImagens = _anuncio.fotos;
    return listaUrlImagens.map((url){
      return Container(
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fitWidth
          )
        ),
      );
    }).toList();

  }

  void _ligarTelefone(String telefone) async {
    telefone = _anuncio.telefone.toString().replaceAll(' ', "%20");

    if( await canLaunch("tel:$telefone") ){
      await launch("tel:$telefone");
    }else{
      print("Não pode fazer a ligação");
    }

  }

  void _whats(String telefone) async {
    telefone = "55" + telefone;
    telefone = telefone.toString().replaceAll(' ', "");
    telefone = telefone.toString().replaceAll('(', "");
    telefone = telefone.toString().replaceAll(')', "");

    await FlutterLaunch.launchWathsApp(phone: telefone, message: "Olá");

  }

  @override
  void initState() {
    super.initState();

    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.phone)
        .then(_updateStatus);

    _anuncio = widget.anuncio;

  }

  _updateStatus(PermissionStatus value) {
    if (value != _status) {
      setState(() {
        _status = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anúncio"),
      ),
      body: Stack(children: <Widget>[

        ListView(children: <Widget>[

          SizedBox(
            height: 250,
            child: Carousel(
              images: _getListaImagens(),
              dotSize: 8,
              dotBgColor: Colors.transparent,
              dotColor: Colors.white,
              autoplay: false,
              dotIncreasedColor: temaPadrao.primaryColor,
            ),
          ),

          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Bloco/Apartamento: ${_anuncio.bloco} ${_anuncio.apartamento}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(),
                ),

              Text(
                "R\$ ${_anuncio.preco}",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: temaPadrao.primaryColor
                ),
              ),

              Text(
                "${_anuncio.titulo}",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(),
              ),

              Text(
                "Descrição",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),

              Text(
                "${_anuncio.descricao}",
                style: TextStyle(
                    fontSize: 18
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(),
              ),

              Text(
                "Contato",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 66),
                child: Text(
                  "${_anuncio.telefone}",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),


            ],),
          ),
      Column(
        children: <Widget>[
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.blueAccent)),
            color: Colors.blueAccent,
            textColor: Colors.white,
            onPressed: () {
              _ligarTelefone(_anuncio.telefone);
            },
            child: Text('Ligar'),
          )]),
          Column(

              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xFF33cc66))),
                  color: Color(0xFF33cc66),
                  textColor: Colors.white,
                  onPressed: () {
                    _whats(_anuncio.telefone);
                  },
                  child: Text('Conversar Whatsapp'),
                )]),
//          Container(
//            left: 16,
//            right: 16,
//            bottom: 16,
//            child: GestureDetector(
//              child: Container(
//                child: Text(
//                  "Ligar",
//                  style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 20
//                  ),
//                ),
//                padding: EdgeInsets.all(16),
//                alignment: Alignment.center,
//                decoration: BoxDecoration(
//                    color: temaPadrao.primaryColor,
//                    borderRadius: BorderRadius.circular(30)
//                ),
//              ),
//              onTap: () => _ligarTelefone(_anuncio.telefone) ,
////            onTap: (){
////              _ligarTelefone( _anuncio.telefone );
//
////            },
//            ),
//          )
        ],),


      ],
      ),
    );
  }
}
