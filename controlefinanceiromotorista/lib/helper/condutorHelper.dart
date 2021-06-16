import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CondutorHelper {
  String apiUrl =
      'https://api-controle-financ-motorista.herokuapp.com/condutor';

  Future<List<Condutor>> getCondutores() async {
    try {
      http.Response response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<Condutor> condutores =
            body.map((dynamic map) => Condutor.from(map));
        return condutores;
      } else if (response.statusCode == 403) {
        throw response.body;
      } else {
        throw 'Falha ao carregar os condutores';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Condutor> getCondutorById(int id) async {
    try {
      http.Response response =
          await http.get(Uri.parse(apiUrl + '/' + id.toString()));
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        return Condutor.from(body);
      } else if (response.statusCode == 403) {
        throw response.body;
      } else {
        throw 'Falha ao carregar o condutor';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Condutor> getCondutorByEmail(String email) async {
    try {
      http.Response response =
          await http.get(Uri.parse(apiUrl + '/email/' + email));
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        return Condutor.from(body);
      } else if (response.statusCode == 403) {
        throw "O login ou a senha estão incorretos!";
      } else {
        throw 'Falha ao carregar o condutor';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Condutor> createCondutor(Condutor condutor) async {
    try {
      Map map = condutor.toMap();
      http.Response response = await http.post(Uri.parse(apiUrl + '/create'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(map));
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        return Condutor.from(body);
      } else if (response.statusCode == 403) {
        throw response.body;
      } else {
        throw 'Falha ao salvar o condutor';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Condutor> updateCondutor(Condutor condutor) async {
    try {
      Map map = condutor.toMap();
      http.Response response = await http.put(Uri.parse(apiUrl + '/update'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(map));
      if (response.statusCode == 200) {
        dynamic body = json.decode(response.body);
        return Condutor.from(body);
      } else if (response.statusCode == 403) {
        throw response.body;
      } else {
        throw 'Falha ao atualizar o condutor';
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteCondutor(Condutor condutor) async {
    try {
      Map map = condutor.toMap();
      http.Response response = await http.delete(Uri.parse(apiUrl + '/delete'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(map));
      if (response.statusCode != 200) {
        throw 'Falha ao remover o condutor';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

class Condutor {
  int id;
  String nome;
  String sobrenome;
  DateTime dataNascimento;
  String email;
  String senha;
  String telefone;
  String imagem;
  String enderecoCep;
  String enderecoLogradouro;
  String enderecoNumero;
  String enderecoBairro;
  String enderecoCidade;
  String enderecoEstado;
  String enderecoComplemento;

  Condutor(
      {int id,
      String nome,
      String sobrenome,
      DateTime dataNascimento,
      String email,
      String senha,
      String telefone,
      String imagem,
      String enderecoCep,
      String enderecoLogradouro,
      String enderecoNumero,
      String enderecoBairro,
      String enderecoCidade,
      String enderecoEstado,
      String enderecoComplemento}) {
    this.id = id;
    this.nome = nome;
    this.sobrenome = sobrenome;
    this.dataNascimento = dataNascimento;
    this.email = email;
    this.senha = senha;
    this.telefone = telefone;
    this.imagem = imagem;
    this.enderecoCep = enderecoCep;
    this.enderecoLogradouro = enderecoLogradouro;
    this.enderecoNumero = enderecoNumero;
    this.enderecoBairro = enderecoBairro;
    this.enderecoCidade = enderecoCidade;
    this.enderecoEstado = enderecoEstado;
    this.enderecoComplemento = enderecoComplemento;
  }

  Condutor.from(Map map) {
    id = map['id'];
    nome = map['nome'];
    sobrenome = map['sobrenome'];
    dataNascimento = DateTime.parse(map['dataNascimento']);
    email = map['email'];
    senha = map['senha'];
    telefone = map['telefone'];
    imagem = map['imagem'];
    enderecoCep = map['enderecoCep'];
    enderecoLogradouro = map['enderecoLogradouro'];
    enderecoNumero = map['enderecoNumero'];
    enderecoBairro = map['enderecoBairro'];
    enderecoCidade = map['enderecoCidade'];
    enderecoEstado = map['enderecoEstado'];
    enderecoComplemento = map['enderecoComplemento'];
  }

  Map toMap() {
    Map<String, Object> map = {
      'nome': nome,
      'sobrenome': sobrenome,
      'dataNascimento': dataNascimento,
      'email': email,
      'senha': senha,
      'telefone': telefone,
      'imagem': imagem,
      'enderecoCep': enderecoCep,
      'enderecoLogradouro': enderecoLogradouro,
      'enderecoNumero': enderecoNumero,
      'enderecoBairro': enderecoBairro,
      'enderecoCidade': enderecoCidade,
      'enderecoEstado': enderecoEstado,
      'enderecoComplemento': enderecoComplemento
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
