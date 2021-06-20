import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ServicoHelper {
  String apiUrl =
      'https://api-controle-financ-motorista.herokuapp.com/servico';

  Future<List<Servico>> getServicos() async {
    try {
      http.Response response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));

        List<Servico> servicos = [];

        body.forEach((element) {           
          servicos.add(Servico.from(element));
        });
        return servicos;
      } else if (response.statusCode == 403) {
        throw utf8.decode(response.bodyBytes);
      } else {
        throw 'Falha ao carregar os condutores';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

class Servico {
  int id;
  String servico;

  Servico(this.id , this.servico);

  Servico.from(Map map) {
    id = map['id'];
    servico = map['servico'];
  }

  Map toMap() {
    Map<String, Object> map = {'servico': servico};
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}