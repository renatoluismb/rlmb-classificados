import 'package:flutter/material.dart';

class BotaoCustomizado extends StatelessWidget {

  final String texto;
  final Color corTexto;
  final Color cor;
  final VoidCallback onPressed;

  BotaoCustomizado({
    @required this.texto,
    @required this.cor,
    this.corTexto = Colors.white,
    this.onPressed
});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
      child: Text(
        this.texto,
        style: TextStyle(
            color: this.corTexto, fontSize: 16
        ),
      ),
      color: this.cor,
      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
      onPressed: this.onPressed,
    );
  }
}
