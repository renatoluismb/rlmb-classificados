import 'dart:io';

import 'package:cvag/termos_aceite.dart';
import 'package:flutter/material.dart';
import 'package:cvag/models/Usuario.dart';
import 'package:cvag/views/widgets/BotaoCustomizado.dart';
import 'package:cvag/views/widgets/InputCustomizado.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';


enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

void mostraMsg(msg) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5);
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


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _textoBotao = "Entrar";

  _cadastrarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      mostraMsgSucesso('Usuário cadastrado com sucesso!');

      //redireciona para tela principal
      Navigator.pushReplacementNamed(context, "/anuncios");

    });

  }

  _logarUsuario(Usuario usuario) async {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user;
    try {
      user = (await auth.signInWithEmailAndPassword(
          email: usuario.email,
          password: usuario.senha).then((firebaseUser) {
        Navigator.pushReplacementNamed(context, "/anuncios");
      },
      ));
    } catch (e) {
      authProblems errorType;
      if (Platform.isAndroid) {
        switch (e.code) {
          case 'ERROR_USER_NOT_FOUND':
            mostraMsg('Usuário não localizado!');
            break;
          case 'ERROR_WRONG_PASSWORD':
            mostraMsg('Senha inválida ou nula');
            break;
          case 'ERROR_TOO_MANY_REQUESTS':
            mostraMsg('Você efetuou muitas requisições simultâneas. Aguarde um momento.');
            break;
        // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      } else if (Platform.isIOS) {
        print(e);
        switch (e.code) {
          case 'ERROR_USER_NOT_FOUND':
            mostraMsg('Usuário não localizado!');
            break;
          case 'ERROR_WRONG_PASSWORD':
            mostraMsg('Senha inválida ou nula');
            break;
          case 'ERROR_TOO_MANY_REQUESTS':
            mostraMsg('Você efetuou muitas requisições simultâneas. Aguarde um momento.');
            break;
        // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      }
      print('The error is $errorType');
    }

//    try {
//      auth.signInWithEmailAndPassword(
//          email: usuario.email,
//          password: usuario.senha).then((firebaseUser){
//
//        //redireciona para tela principal
//        Navigator.pushReplacementNamed(context, "/");
//
//      });
//    } catch (error) {
//      print('caiu aqui');
//      print (error.toString());
//    }


  }

  _EsqueciSenha() async {

    FirebaseAuth auth = FirebaseAuth.instance;

    //Recupera dados dos campos
    String email = _controllerEmail.text;

    if (email.isNotEmpty && email.contains("@")) {

        //Configura usuario
        Usuario usuario = Usuario();
        usuario.email = email;
        try {
        await auth.sendPasswordResetEmail(email: usuario.email).then((firebaseUser){;
           mostraMsgSucesso('Você receberá um e-mail com as instruções para recuperar sua senha!');
           });
         } catch (error) {
            print('caiu aqui');
            print (error.toString());
        }
        } else {
      setState(() {
        _mensagemErro = "* Preencha o E-mail válido";
      });
    }

  }

  _validarCampos() {

    //Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 5) {

        //Configura usuario
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        //cadastrar ou logar
        if( _cadastrar ){
          print(usuario);
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => TermosAceite(usuario)
          ));
        }else{
          //Logar
          _logarUsuario(usuario);
        }

      } else {
        setState(() {
          _mensagemErro = "* Preencha a senha! digite mais de 6 caracteres";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "* Preencha o E-mail válido";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(""),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            new Row (
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CLASSIFICADOS\n",
                    style: TextStyle(
                        fontSize: 38,
                      fontFamily: 'Baloo',
                      fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                      color: Color(0xFF00486b),
                    ),
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.only(bottom: 52),
                  child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child: SvgPicture.asset(
                      'imagens/logo_novo.svg',
                      width: 180.0,
                      height: 220.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                InputCustomizado(
                  controller: _controllerEmail,
                  hint: "E-mail",
                  autofocus: true,
                  type: TextInputType.emailAddress,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                ),
                InputCustomizado(
                  controller: _controllerSenha,
                  hint: "Senha",
                  obscure: true
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Logar",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Baloo',
//                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                        color: Colors.teal,
                      ),),
                    Switch(
                      focusColor: Colors.teal,
                      activeColor: Colors.blue,
                      inactiveTrackColor: Colors.teal,
                      value: _cadastrar,
                      onChanged: (bool valor){
                        setState(() {
                          _cadastrar = valor;
                          _textoBotao = "Entrar";
                          if( _cadastrar ){
                            _textoBotao = "Cadastrar";
                          }
                        });
                      },
                    ),
                    Text("Cadastrar",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Arial',
//                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue,
                      ),),
                  ],
                ),
                BotaoCustomizado(
                  texto: _textoBotao,
                  onPressed: (){
                    _validarCampos();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20)
                ),
                FlatButton(
                  child: Text("Ir para anúncios", style: TextStyle(
                      color: Colors.white, fontSize: 16
                  ),),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)
                  ),
                  color: Colors.blueAccent,
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, "/anuncios");
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(_mensagemErro, style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                  ),),
                ),
                FlatButton(
                  child: Text("Esqueci minha senha", style: TextStyle(
                      color: Colors.black45, fontSize: 16
                  ),),
                  onPressed: (){
                    _EsqueciSenha();
                  },
                ),
            ],),
          ),
        ),
      ),
    );
  }
}
