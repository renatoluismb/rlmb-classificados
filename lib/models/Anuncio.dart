
import 'package:cloud_firestore/cloud_firestore.dart';

class Anuncio{

  String _id;
  String _estado;
  String _categoria;
  String _titulo;
  String _preco;
  String _telefone;
  String _descricao;
  String _bloco;
  String _apartamento;
  Timestamp _dataInclusao;
  List<String> _fotos;

  Anuncio();

  Anuncio.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){

    this.id = documentSnapshot.documentID;
    this.estado = documentSnapshot["estado"];
    this.categoria = documentSnapshot["categoria"];
    this.titulo     = documentSnapshot["titulo"];
    this.preco      = documentSnapshot["preco"];
    this.telefone   = documentSnapshot["telefone"];
    this.descricao  = documentSnapshot["descricao"];
    this.bloco  = documentSnapshot["bloco"];
    this.apartamento  = documentSnapshot["apartamento"];
    this._dataInclusao  = documentSnapshot["dataInclusao"];
    this.fotos  = List<String>.from(documentSnapshot["fotos"]);

  }

  Anuncio.gerarId(){

    Firestore db = Firestore.instance;
    CollectionReference anuncios = db.collection("meus_anuncios");
    this.id = anuncios.document().documentID;

    this.fotos = [];

  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "id" : this.id,
      "estado" : this.estado,
      "categoria" : this.categoria,
      "titulo" : this.titulo,
      "preco" : this.preco,
      "telefone" : this.telefone,
      "descricao" : this.descricao,
      "bloco" : this.bloco,
      "apartamento" : this.apartamento,
      "fotos" : this.fotos,
      "dataInclusao" : this._dataInclusao,
    };

    return map;

  }

  List<String> get fotos => _fotos;

  set fotos(List<String> value) {
    _fotos = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get bloco => _bloco;

  set bloco(String value) {
    _bloco = value;
  }

  String get apartamento => _apartamento;

  set apartamento(String value) {
    _apartamento = value;
  }


  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get preco => _preco;

  set preco(String value) {
    _preco = value;
  }

  Timestamp get dataInclusao => _dataInclusao;

  set dataInclusao(Timestamp value) {
    _dataInclusao = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }


}