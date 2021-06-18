import 'dart:convert';

import 'package:controlefinanceiromotorista/helper/cepHelper.dart';
import 'package:controlefinanceiromotorista/helper/localHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:controlefinanceiromotorista/helper/condutorHelper.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class telaCadastro extends StatefulWidget {
  final Condutor condutor;

  telaCadastro({this.condutor});

  @override
  _telaCadastro createState() => _telaCadastro();
}

class _telaCadastro extends State<telaCadastro> {
  final CondutorHelper _condutorHelper = new CondutorHelper();
  final CepHelper _cepHelper = new CepHelper();

  Condutor _condutor;

  List<String> _estados = [];
  List<String> _cidades = [];

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _sobrenomeController = TextEditingController();
  TextEditingController _dataNascController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _endCepController = TextEditingController();
  TextEditingController _endEstadoController = TextEditingController();
  TextEditingController _endCidadeController = TextEditingController();
  TextEditingController _endBairroController = TextEditingController();
  TextEditingController _endLogradouroController = TextEditingController();
  TextEditingController _endNumeroController = TextEditingController();
  TextEditingController _endComplementoController = TextEditingController();

  final FocusNode _nomeFocus = FocusNode();
  final FocusNode _sobrenomeFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _senhaFocus = FocusNode();
  final FocusNode _telefoneFocus = FocusNode();
  final FocusNode _endCepFocus = FocusNode();
  final FocusNode _endEstadoFocus = FocusNode();
  final FocusNode _endCidadeFocus = FocusNode();
  final FocusNode _endBairroFocus = FocusNode();
  final FocusNode _endLogradouroFocus = FocusNode();
  final FocusNode _endNumeroFocus = FocusNode();
  final FocusNode _endComplementoFocus = FocusNode();

  final DateFormat formatterDate = DateFormat("dd/MM/yyyy");

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.condutor != null) {
      _condutor = Condutor.from(widget.condutor.toMap());

      _nomeController.text = _condutor.nome;
      _sobrenomeController.text = _condutor.sobrenome;
      _dataNascController.text = formatterDate.format(_condutor.dataNascimento);
      _emailController.text = _condutor.email;
      _senhaController.text = _condutor.senha;
      _telefoneController.text = _condutor.telefone;
      _endCepController.text = _condutor.enderecoCep;
      _endEstadoController.text = _condutor.enderecoEstado;
      _endCidadeController.text = _condutor.enderecoCidade;
      _endBairroController.text = _condutor.enderecoBairro;
      _endLogradouroController.text = _condutor.enderecoLogradouro;
      _endNumeroController.text = _condutor.enderecoNumero;
      _endComplementoController.text = _condutor.enderecoComplemento;
    } else {
      _condutor = new Condutor();
    }
    LocalHelper.loadCidadesEstados().then((value) {
      setState(() {
        _estados.clear();
        _estados = LocalHelper.getEstados();
        _cidades.clear();
        _cidades = LocalHelper.getCidades(estado: _condutor.enderecoEstado);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_condutor.nome ?? "Preencha seus dados pessoais"),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveCondutor,
        label: Text("Salvar"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: SingleChildScrollView(
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
                      image: _condutor.imagem != null &&
                              _condutor.imagem.isNotEmpty
                          ? MemoryImage(base64Decode(_condutor.imagem))
                          : AssetImage("images/person.png"),
                    ),
                  ),
                ),
                onTap: () {
                  _changePicture(context);
                },
              ),
              TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: "Nome:"),
                controller: _nomeController,
                focusNode: _nomeFocus,
                onChanged: (text) {
                  setState(() {
                    _condutor.nome = text;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: "Sobrenome:"),
                controller: _sobrenomeController,
                focusNode: _sobrenomeFocus,
                onChanged: (text) {
                  setState(() {
                    _condutor.sobrenome = text;
                  });
                },
              ),
              DateTimeField(
                decoration: InputDecoration(labelText: "Data de Nascimento:"),
                controller: _dataNascController,
                format: formatterDate,
                onShowPicker: (ctx, currentValue) {
                  return showDatePicker(
                      context: ctx,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime.now());
                },
                onChanged: (date) {
                  setState(() {
                    _condutor.dataNascimento = date;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "E-mail:"),
                controller: _emailController,
                focusNode: _emailFocus,
                onChanged: (text) {
                  setState(() {
                    _condutor.email = text;
                  });
                },
              ),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(labelText: 'Senha:'),
                controller: _senhaController,
                focusNode: _senhaFocus,
                onChanged: (text) {
                  setState(() {
                    _condutor.senha = text;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Telefone:"),
                controller: _telefoneController,
                focusNode: _telefoneFocus,
                onChanged: (text) {
                  setState(() {
                    _condutor.telefone = text;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "CEP:"),
                controller: _endCepController,
                focusNode: _endCepFocus,
                onChanged: (text) {
                  if (text.length == 8) {
                    _cepHelper.getCep(text).then((value) {
                      if (_endEstadoController.text != value.uf) {
                        _endEstadoController.text = value.uf;
                        _cidades.clear();
                        _cidades = LocalHelper.getCidades(estado: value.uf);
                      }
                      _endCidadeController.text = value.localidade;
                      _endBairroController.text = value.bairro;
                      _endLogradouroController.text = value.logradouro;
                      _endComplementoController.text = value.complemento;
                      setState(() {
                        _condutor.enderecoEstado = value.uf;
                        _condutor.enderecoCidade = value.localidade;
                        _condutor.enderecoBairro = value.bairro;
                        _condutor.enderecoLogradouro = value.logradouro;
                        _condutor.enderecoComplemento = value.complemento;
                      });
                    }).catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(e),
                        duration: new Duration(seconds: 1),
                      ));
                    });
                  }
                  setState(() {
                    _condutor.enderecoCep = text;
                  });
                },
              ),
              DropDownField(
                controller: _endEstadoController,
                value: _condutor.enderecoEstado,
                strict: true,
                labelText: 'UF:',
                labelStyle: TextStyle(decoration: TextDecoration.none),
                textStyle: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.normal,
                ),
                items: _estados,
                onValueChanged: (value) {
                  if (_condutor.enderecoEstado != value) {
                    _endCidadeController.text = "";
                    setState(() {
                      _condutor.enderecoEstado = value;
                      _condutor.enderecoCidade = null;
                      _cidades.clear();
                      _cidades = LocalHelper.getCidades(estado: value);
                    });
                  }
                },
              ),
              DropDownField(
                controller: _endCidadeController,
                value: _condutor.enderecoCidade,
                strict: true,
                labelStyle: TextStyle(decoration: TextDecoration.none),
                labelText: 'Cidade:',
                textStyle: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.normal,
                ),
                items: _cidades,
                onValueChanged: (value) {
                  if (_condutor.enderecoCidade != value) {
                    setState(() {
                      _condutor.enderecoCidade = value;
                    });
                  }
                },
              ),
              TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: "Bairro:"),
                controller: _endBairroController,
                focusNode: _endBairroFocus,
                onChanged: (text) {
                  setState(() {
                    _condutor.enderecoBairro = text;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: "Logradouro:"),
                controller: _endLogradouroController,
                focusNode: _endLogradouroFocus,
                onChanged: (text) {
                  setState(() {
                    _condutor.enderecoLogradouro = text;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Nº:"),
                controller: _endNumeroController,
                focusNode: _endNumeroFocus,
                onChanged: (text) {
                  setState(() {
                    _condutor.enderecoNumero = text;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: "Complemento:"),
                controller: _endComplementoController,
                focusNode: _endComplementoFocus,
                onChanged: (text) {
                  setState(() {
                    _condutor.enderecoComplemento = text;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changePicture(context) {
    final ImagePicker _picker = ImagePicker();

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeria'),
                      onTap: () {
                        _picker
                            .getImage(
                                source: ImageSource.gallery,
                                imageQuality: 50,
                                maxHeight: 600,
                                maxWidth: 900)
                            .then((file) {
                          if (file == null) return;
                          setState(() {
                            file
                                .readAsBytes()
                                .then((value) =>
                                    _condutor.imagem = base64Encode(value))
                                .catchError((e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "Ocorreu um erro ao carregar a imagem!"),
                                duration: new Duration(seconds: 1),
                              ));
                            });
                          });
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Câmera'),
                    onTap: () {
                      _picker
                          .getImage(
                              source: ImageSource.camera,
                              imageQuality: 50,
                              maxHeight: 600,
                              maxWidth: 900)
                          .then((file) {
                        if (file == null) return;
                        setState(() {
                          file
                              .readAsBytes()
                              .then((value) =>
                                  _condutor.imagem = base64Encode(value))
                              .catchError((e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Ocorreu um erro ao carregar a imagem!"),
                              duration: new Duration(seconds: 1),
                            ));
                          });
                        });
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _saveCondutor() {
    if (_condutor.nome == null || _condutor.nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("O nome deve ser preenchido!"),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_nomeFocus);
      return;
    }
    if (_condutor.sobrenome == null || _condutor.sobrenome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("O sobrenome deve ser preenchido!"),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_sobrenomeFocus);
      return;
    }
    if (_condutor.dataNascimento == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("A data de nascimento deve ser preenchida!"),
        duration: new Duration(seconds: 1),
      ));
      return;
    }
    if (_condutor.email == null || _condutor.email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("O email deve ser preenchido!"),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_emailFocus);
      return;
    }
    if (_condutor.senha == null || _condutor.senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("A senha deve ser preenchida!"),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_senhaFocus);
      return;
    }
    if (_condutor.telefone == null || _condutor.telefone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("O telefone deve ser preenchido!"),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_telefoneFocus);
      return;
    }
    if (_condutor.enderecoCep == null || _condutor.enderecoCep.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("O CEP deve ser preenchido!"),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_endCepFocus);
      return;
    }
    if (_condutor.enderecoEstado == null || _condutor.enderecoEstado.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("O estado deve ser preenchido!"),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_endEstadoFocus);
      return;
    }
    if (_condutor.enderecoCidade == null || _condutor.enderecoCidade.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("A cidade deve ser preenchida!"),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_endCidadeFocus);
      return;
    }
    if (_condutor.enderecoBairro == null || _condutor.enderecoBairro.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("O bairro deve ser preenchido!"),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_endBairroFocus);
      return;
    }
    if (_condutor.enderecoLogradouro == null ||
        _condutor.enderecoLogradouro.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("O logradouro deve ser preenchido!"),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_endLogradouroFocus);
      return;
    }
    if (_condutor.enderecoNumero == null || _condutor.enderecoNumero.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("O número deve ser preenchido!"),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_endNumeroFocus);
      return;
    }
    setState(() {
      _saving = true;
    });
    _condutorHelper.saveCondutor(_condutor).then((value) {
      setState(() {
        _saving = false;
      });
      Navigator.pop(context, _condutor);
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
}
