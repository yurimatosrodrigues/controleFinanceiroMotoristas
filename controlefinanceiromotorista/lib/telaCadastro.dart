import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class telaCadastro extends StatefulWidget {
  @override
  _telaCadastro createState() => _telaCadastro();
}

class _telaCadastro extends State<telaCadastro> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preencha seus dados pessoais"),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {}, label: Text("Avançar")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("images/person.png"),
                    )),
              ),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Nome Completo:"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Data de Nascimento:"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "E-mail:"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Telefone:"),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              decoration: InputDecoration(labelText: "CEP:"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Logradouro:"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Nº:"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Bairro:"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Cidade:"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "UF:"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Complemento:"),
            ),
          ],
        ),
      ),
    );
  }
}
