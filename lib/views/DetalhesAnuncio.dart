import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cvag/main.dart';
import 'package:cvag/models/Anuncio.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:intl/intl.dart';
import 'package:share_social_media_plugin/share_social_media_plugin.dart';

class DetalhesAnuncio extends StatefulWidget {

  Anuncio anuncio;
  DetalhesAnuncio(this.anuncio);

  @override
  _DetalhesAnuncioState createState() => _DetalhesAnuncioState();
}

class _DetalhesAnuncioState extends State<DetalhesAnuncio> {

  CarouselController buttonCarouselController = CarouselController();

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

    var saudacao = '';
    var titulo = _anuncio.titulo;
    var hour = DateTime.now().hour;

    if (hour < 12) {
      saudacao = 'Bom dia';
    } else if (hour < 18) {
      saudacao =  'Boa tarde';
    } else {
      saudacao = 'Boa noite';
    }

    var msg = Uri.encodeComponent('Olá vizinho, $saudacao! Gostaria de conversar sobre o anúncio: $titulo');

    print(msg);

    telefone = "55" + telefone;
    telefone = telefone.toString().replaceAll(' ', "");
    telefone = telefone.toString().replaceAll('(', "");
    telefone = telefone.toString().replaceAll(')', "");

    await FlutterOpenWhatsapp.sendSingleMessage(telefone, msg);



//    await FlutterLaunch.launchWathsApp(phone: telefone, text: msg ?? "");

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //store btn
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              backgroundColor: Color(0xFF33cc66),
              child: new IconButton(
                  icon: new Icon(MdiIcons.whatsapp, color: Colors.white)),
              onPressed: () {
                _whats(_anuncio.telefone);
              },
              heroTag: null,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            ),
            FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              child: new IconButton(
                  icon: new Icon(MdiIcons.phone, color: Colors.white)),
              onPressed: () {
                _ligarTelefone(_anuncio.telefone);
              },
              heroTag: null,
            ),
          ]
      ),
      body: Stack(children: <Widget>[

        ListView(children: <Widget>[

          SizedBox(
            height: 250,
            child:  CarouselSlider(
              items: _getListaImagens(),
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                height: 250,
                aspectRatio: 0.5,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 400),
                autoPlayCurve: Curves.decelerate,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
                width: 30,
                child: RaisedButton(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(19)
//                  ),
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(2, 9, 2, 6),
                  onPressed: () => buttonCarouselController.previousPage(),
                  child: Text(' ← ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: RaisedButton(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(6)
//                  ),
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(2, 9 , 2, 6),
                  onPressed: () => buttonCarouselController.nextPage(),
                  child: Text(' → ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
              ),
//              ...Iterable<int>.generate(_getListaImagens().length).map(
//                    (int pageIndex) => Flexible(
//                  child: RaisedButton(
//                    onPressed: () => buttonCarouselController.animateToPage(pageIndex),
//                    child: Text("$pageIndex"),
//                  ),
//                ),
//              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Bloco: ${_anuncio.bloco} - Apartamento: ${_anuncio.apartamento}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Anúncio incluído em: ${DateFormat('dd/MM/yyyy – kk:mm').format(DateTime.parse(_anuncio.dataInclusao.toDate().toString()))}",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45
//                      fontWeight: FontWeight.bold
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
                padding: EdgeInsets.only(bottom: 50),
                child: Text(
                  "${_anuncio.telefone}",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),


            ],),
          ),
//      Column(
//        children: <Widget>[
//          RaisedButton(
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(18.0),
//                side: BorderSide(color: Colors.blueAccent)),
//            color: Colors.blueAccent,
//            textColor: Colors.white,
//            onPressed: () {
//              _ligarTelefone(_anuncio.telefone);
//            },
//            child: Text('Ligar'),
//          )]),
//          Column(
//
//              children: <Widget>[
//                RaisedButton(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(18.0),
//                      side: BorderSide(color: Color(0xFF33cc66))),
//                  color: Color(0xFF33cc66),
//                  textColor: Colors.white,
//                  onPressed: () {
//                    _whats(_anuncio.telefone);
//                  },
//                  child: Text('Conversar Whatsapp'),
//                )]),
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
