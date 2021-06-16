import 'package:controlefinanceiromotorista/helper/condutorHelper.dart';
import 'package:controlefinanceiromotorista/telaCadastro.dart';
import 'package:controlefinanceiromotorista/telaPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final CondutorHelper _helper = new CondutorHelper();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  FocusNode _loginFocus = FocusNode();
  FocusNode _senhaFocus = FocusNode();
  bool _saving = false;

  void _onLoginPressed() {
    String login = _loginController.text;
    if (login == null || login.isEmpty) {
      FocusScope.of(context).requestFocus(_loginFocus);
      return;
    }
    String senha = _senhaController.text;
    if (senha == null || senha.isEmpty) {
      FocusScope.of(context).requestFocus(_senhaFocus);
      return;
    }
    setState(() {
      _saving = true;
    });
    _helper.getCondutorByEmail(_loginController.text).then((condutor) {
      setState(() {
        _saving = false;
      });
      if (senha == condutor.senha) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => telaPrincipal()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("O login ou a senha estão incorretos!"),
          duration: new Duration(seconds: 3),
        ));
      }
    }).catchError((e) {
      setState(() {
        _saving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e),
        duration: new Duration(seconds: 3),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                //Local a se colocar o logo
                Icon(
                  Icons.account_circle,
                  size: 120.0,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "LOGIN",
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  controller: _loginController,
                  focusNode: _loginFocus,
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "SENHA",
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  controller: _senhaController,
                  focusNode: _senhaFocus,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 150,
                  height: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _onLoginPressed,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 150,
                  height: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                      "CRIAR CONTA",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => telaCadastro()),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
