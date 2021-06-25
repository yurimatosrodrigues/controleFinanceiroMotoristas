import 'dart:async';
import 'dart:convert';

import 'package:controlefinanceiromotorista/helper/servicoHelper.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LancamentoHelper {
  String apiUrl =
      'https://api-controle-financ-motorista.herokuapp.com/lancamento';

  Future<List<Lancamento>> getLancamento() async {
    try {
      http.Response response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
        List<Lancamento> lancamentos =
        body.map((dynamic map) => Lancamento.from(map));
        return lancamentos;
      } else if (response.statusCode == 403) {
        throw utf8.decode(response.bodyBytes);
      } else {
        throw 'Falha ao carregar os lancamentos';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Lancamento>> getLancamentoByCondutor(int idCondutor) async {
    try {
      http.Response response = await http
          .get(Uri.parse(apiUrl + '/condutor/' + idCondutor.toString()));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
        List<Lancamento> lancamentos = [];
        body.forEach((element) {           
          lancamentos.add(Lancamento.from(element));
        });
        return lancamentos;
      } else if (response.statusCode == 403) {
        throw utf8.decode(response.bodyBytes);
      } else {
        throw 'Falha ao carregar o Lancamento pelo ID do condutor';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Lancamento> getLancamentoById(int id) async {
    try {
      http.Response response =
      await http.get(Uri.parse(apiUrl + '/' + id.toString()));
      if (response.statusCode == 200) {
        dynamic body = json.decode(utf8.decode(response.bodyBytes));
        return Lancamento.from(body);
      } else if (response.statusCode == 403) {
        throw utf8.decode(response.bodyBytes);
      } else {
        throw 'Falha ao carregar o Lancamento';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Lancamento> createLancamento(Lancamento lancamento) async {
    try {
      Map map = lancamento.toMap();
      http.Response response = await http.post(Uri.parse(apiUrl + '/create'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(map));
      if (response.statusCode == 200) {
        dynamic body = json.decode(utf8.decode(response.bodyBytes));
        return Lancamento.from(body);
      } else if (response.statusCode == 403) {
        throw utf8.decode(response.bodyBytes);
      } else {
        throw 'Falha ao salvar o lancamento';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Lancamento> updateLancamento(Lancamento lancamento) async {
    try {
      Map map = lancamento.toMap();
      http.Response response = await http.put(Uri.parse(apiUrl + '/update'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(map));
      if (response.statusCode == 200) {
        dynamic body = json.decode(utf8.decode(response.bodyBytes));
        return Lancamento.from(body);
      } else if (response.statusCode == 403) {
        throw utf8.decode(response.bodyBytes);
      } else {
        throw 'Falha ao atualizar o lancamento';
      }
    } catch (e) {
      throw e;
    }
  }

  Future<Lancamento> saveLancamento(Lancamento lancamento) async {
    try {
      if (lancamento.id == null) {
        return createLancamento(lancamento);
      } else {
        return updateLancamento(lancamento);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteLancamento(Lancamento lancamento) async {
    try {
      Map map = lancamento.toMap();
      http.Response response = await http.delete(Uri.parse(apiUrl + '/delete'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(map));
      if (response.statusCode != 200) {
        throw 'Falha ao remover o lancamento';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

class Lancamento {
  int id;
  int idCondutor;
  Servico servico;
  int idServico;
  int entrada;
  double valor;
  DateTime data;
  String descricao;
  String infoAdicional;

  Lancamento(
      {int id,
        int idCondutor,
        Servico servico,
        int idServico,
        int entrada,
        double valor,
        DateTime data,
        String descricao,
        String infoAdicional}) {
    this.id = id;
    this.idCondutor = idCondutor;
    this.servico = servico;
    this.idServico = idServico;
    this.entrada = entrada;
    this.valor = valor;
    this.data = data;
    this.descricao = descricao;
    this.infoAdicional = infoAdicional;
  }

  Lancamento.from(Map map) {
    id = map['id'];
    idCondutor = map['idCondutor'];
    if (map['servico'].runtimeType.toString() == 'Servico'){
      servico = map['servico'];
    }
    else{
      servico = Servico.from(map['servico']);
    }
    idServico = map['idServico'];
    entrada = map['entrada'];
    valor = map['valor'];
    data = DateTime.parse(map['data']);
    descricao = map['descricao'];
    infoAdicional = map['infoAdicional'];
  }
  Map toMap() {
    Map<String, Object> map = {
      'idCondutor': idCondutor,      
      'servico' :(servico!= null) ? servico.toMap() : null ,      
      'idServico': idServico,
      'entrada': entrada,
      'valor': valor,
      'data': DateFormat("yyyy-MM-dd").format(data),
      'descricao': descricao,
      'infoAdicional': infoAdicional
    };
    if (id != null) {
      map['id'] = id;
    }
    if (idCondutor != null) {
      map['idCondutor'] = idCondutor;
    }
    if (id != null) {
      map['idServico'] = idServico;
    }
    return map;
  }
}