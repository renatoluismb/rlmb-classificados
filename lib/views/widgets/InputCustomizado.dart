import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustomizado extends StatelessWidget {

  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;
  final int maxLines;
  final List<TextInputFormatter> inputFormatters;
  final Function(String) validator;
  final Function(String) onSaved;

  InputCustomizado({
    @required this.controller,
    @required this.hint,
    this.obscure = false,
    this.autofocus = false,
    this.type = TextInputType.text,
    this.inputFormatters,
    this.maxLines = 1,
    this.validator,
    this.onSaved
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      obscureText: this.obscure,
      autofocus: this.autofocus,
      keyboardType: this.type,
      inputFormatters: this.inputFormatters,
      validator: this.validator,
      maxLines: this.maxLines,
      onSaved: this.onSaved,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          hintText: this.hint,
          filled: true,
          fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.teal, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
          borderSide: BorderSide(color: Color(0xFF00486b), width: 1.0),
        ),
      ),
    );
  }
}
