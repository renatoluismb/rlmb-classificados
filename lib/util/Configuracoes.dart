import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class Configuracoes {

  static List<DropdownMenuItem<String>> getEstados(){

    List<DropdownMenuItem<String>> listaItensDropEstados = [];

    //Categorias
    listaItensDropEstados.add(
        DropdownMenuItem(child: Text(
          "Região", style: TextStyle(
            color: Colors.teal
        ),
        ), value: null,)
    );

    for( var estado in Estados.listaEstadosAbrv ){
      listaItensDropEstados.add(
          DropdownMenuItem(child: Text(estado), value: estado,)
      );
    }

    return listaItensDropEstados;

  }

  static List<DropdownMenuItem<String>> getCategorias(){

    List<DropdownMenuItem<String>> itensDropCategorias = [];

    //Categorias
    itensDropCategorias.add(
        DropdownMenuItem(child: Text(
            "Busca por Categoria", style: TextStyle(
          color: Colors.teal
        ),
        ), value: null,)
    );

    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Automóveis"), value: "auto",)
    );

    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Eletrônicos"), value: "eletro",)
    );

    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Imóveis"), value: "imovel",)
    );


    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Moda e beleza"), value: "moda",)
    );

    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Móveis"), value: "moveis",)
    );

    itensDropCategorias.add(
        DropdownMenuItem(child: Text("Serviços"), value: "servicos",)
    );

    return itensDropCategorias;

  }

  static List<DropdownMenuItem<String>> getBlocos(){

    List<DropdownMenuItem<String>> itensDropBlocos = [];

    //Categorias
    itensDropBlocos.add(
        DropdownMenuItem(child: Text(
          "Bloco", style: TextStyle(
            color: Colors.teal
        ),
        ), value: null,)
    );

    itensDropBlocos.add(
        DropdownMenuItem(child: Text("A"), value: "A",)
    );

    itensDropBlocos.add(
        DropdownMenuItem(child: Text("B"), value: "B",)
    );

    itensDropBlocos.add(
        DropdownMenuItem(child: Text("C"), value: "C",)
    );

    return itensDropBlocos;

  }

}