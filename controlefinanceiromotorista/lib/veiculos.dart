import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const requestMarcas = 'https://api-controle-financ-motorista.herokuapp.com//marca-veiculo';

class Marca{
  

  int _idMarca;
  String _marca;
  

  Future<Map> getMarcas() async{
    http.Response response = await http.get(Uri.parse(requestMarcas));
    print(response.body);
    return json.decode(response.body);
  }

}