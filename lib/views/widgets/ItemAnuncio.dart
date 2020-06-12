import 'package:flutter/material.dart';
import 'package:cvag/models/Anuncio.dart';

class ItemAnuncio extends StatelessWidget {

  Anuncio anuncio;
  VoidCallback onTapItem;
  VoidCallback onPressedRemover;
  VoidCallback onPressedEditar;

  ItemAnuncio({
    @required this.anuncio,
    this.onTapItem,
    this.onPressedRemover,
    this.onPressedEditar
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
          elevation: 2.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18)
        ),
//          shadowColor: Colors.blueAccent,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(children: <Widget>[

            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                anuncio.fotos[0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text(
                      anuncio.titulo,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                  Text("R\$ ${anuncio.preco} "),
                ],),
              ),
            ),
            if ( this.onPressedEditar != null ) Expanded(
              flex: 1,
              child: FlatButton(
                color: Colors.blueAccent,
                padding: EdgeInsets.all(10),
                onPressed: this.onPressedEditar,
                child: Icon(Icons.mode_edit, color: Colors.white,),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
            if ( this.onPressedRemover != null ) Expanded(
              flex: 1,
              child: FlatButton(
                color: Colors.red,
                padding: EdgeInsets.all(10),
                onPressed: this.onPressedRemover,
                child: Icon(Icons.delete, color: Colors.white,),
              ),
            )
            //botao remover

          ],),
        ),
      ),
    );
  }
}
