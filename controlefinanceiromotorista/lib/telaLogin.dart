import 'package:controlefinanceiromotorista/telaCadastro.dart';
import 'package:controlefinanceiromotorista/telaPrincipal.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              //Local a ser colocar o logo
              Icon(
                Icons.account_circle,
                size: 120.0,
                color: Colors.black,
              ),

              SizedBox(
                height: 30,
              ),

              TextField(
                decoration: InputDecoration(
                  labelText: "LOGIN",
                  labelStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              TextField(
                decoration: InputDecoration(
                  labelText: "SENHA",
                  labelStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(),
                ),
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
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> telaPrincipal()));
                  },
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> telaCadastro()));
                  },
                ),
              )
            ],
          ),
        ),
      )

    );

  }
}
