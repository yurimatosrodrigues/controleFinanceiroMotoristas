import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class CepHelper {
  String apiUrl = 'https://viacep.com.br/ws/';

  Future<Cep> getCep(String cep) async {
    try {
      http.Response response =
          await http.get(Uri.parse(apiUrl + cep + '/json'));
      if (response.statusCode == 200) {
        dynamic body = json.decode(utf8.decode(response.bodyBytes));
        return Cep.from(body);
      } else {
        throw 'Falha ao localizar CEP';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

class Cep {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String unidade;
  String ibge;
  String gia;

  Cep(
      {String cep,
      String logradouro,
      String complemento,
      String bairro,
      String localidade,
      String uf,
      String unidade,
      String ibge,
      String gia}) {
    this.cep = cep;
    this.logradouro = logradouro;
    this.complemento = complemento;
    this.bairro = bairro;
    this.localidade = localidade;
    this.uf = uf;
    this.unidade = unidade;
    this.ibge = ibge;
    this.gia = gia;
  }

  Cep.from(Map map) {
    cep = map["cep"];
    logradouro = map["logradouro"];
    complemento = map["complemento"];
    bairro = map["bairro"];
    localidade = map["localidade"];
    uf = map["uf"];
    unidade = map["unidade"];
    ibge = map["ibge"];
    gia = map["gia"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "cep": cep,
      "logradouro": logradouro,
      "complemento": complemento,
      "bairro": bairro,
      "localidade": localidade,
      "uf": uf,
      "unidade": unidade,
      "ibge": ibge,
      "gia": gia,
    };
    return map;
  }
}
