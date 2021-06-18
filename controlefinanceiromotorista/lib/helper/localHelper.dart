import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

class LocalHelper {
  static List<Estado> estados = [];

  static Future<void> loadCidadesEstados() async {
    try {
      String text =
          await rootBundle.loadString('assets/json/estados_cidades.json');
      var jsonData = json.decode(text);
      estados.clear();
      jsonData["estados"].forEach((element) {
        estados.add(Estado.from(element));
      });
    } catch (e) {
      estados = [];
    }
  }

  static List<String> getEstados() {
    List<String> list = [];
    estados.forEach((element) {
      list.add(element.sigla);
    });
    list.sort((a, b) => a.compareTo(b));
    return list;
  }

  static List<String> getCidades({String estado}) {
    List<String> list = [];
    var filter = estados.where((element) => element.sigla == estado).toList();
    filter.forEach((element) {
      element.cidades.forEach((item) {
        list.add(item);
      });
    });
    list.sort((a, b) => a.compareTo(b));
    return list;
  }
}

class Estado {
  String sigla;
  String nome;
  List<dynamic> cidades;

  Estado({String sigla, String nome, List<String> cidades}) {
    this.sigla = sigla;
    this.nome = nome;
    this.cidades = cidades;
  }

  Estado.from(Map map) {
    sigla = map['sigla'];
    nome = map['nome'];
    cidades = map['cidades'];
  }

  Map toMap() {
    Map<String, Object> map = {
      'sigla': sigla,
      'nome': nome,
      'cidades': cidades
    };
    return map;
  }
}
