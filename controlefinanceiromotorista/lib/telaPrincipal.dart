import 'dart:convert';

import 'package:controlefinanceiromotorista/helper/lancamentoHelper.dart';
import 'package:flutter/material.dart';

import 'package:controlefinanceiromotorista/helper/condutorHelper.dart';
import 'package:controlefinanceiromotorista/telaCadastro.dart';
import 'package:controlefinanceiromotorista/telaLancamento.dart';

import 'package:intl/intl.dart';

class telaPrincipal extends StatefulWidget {
  final Condutor condutor;

  telaPrincipal({this.condutor});

  @override
  _telaPrincipalState createState() => _telaPrincipalState();
}

class _telaPrincipalState extends State<telaPrincipal> {
  Condutor _condutor;

  LancamentoHelper _lancamentoHelper = LancamentoHelper();  
  Future<List<Lancamento>> _futureLancamentos;
  List<Lancamento> _lancamentos;

  final DateFormat _formatoData = DateFormat("dd/MM/yyyy");

  @override
  void initState() {
    super.initState();
    if (widget.condutor != null) {
      _condutor = Condutor.from(widget.condutor.toMap());
    }
    _futureLancamentos = _lancamentoHelper.getLancamentoByCondutor(_condutor.id);
  }

  void _showTelaLancamentos() async{
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => TelaLancamento(_condutor.id)));
  }

  Widget _buildListaLancamentos(){
    return FutureBuilder<List<Lancamento>>(
      future: _futureLancamentos,
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if(snapshot.hasError){
              return Text('Erro ao carregar lançamentos.');
            }
            else{     
              _lancamentos = snapshot.data;   
              
              return ListView.builder(                
                itemCount: _lancamentos.length,
                itemBuilder: (context, index){
                  return _buildCardLancamento(context,index);
                });
            }
        }
      },
    );
  }

  Widget _buildCardLancamento(context, index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            children: [
              Container(
                child: Column(
                  children: [
                    Text(
                      _formatoData.format(_lancamentos[index].data),
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    Text(
                      _lancamentos[index].servico.servico,
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'R\$ ' + _lancamentos[index].valor.toString(),
                  style: TextStyle(
                        fontSize: 40.0
                      ),
                ),
              )
            ],
          ),
        )         
      )
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Criação do MENU
      drawer: Drawer(
        child: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
            DrawerHeader(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: _condutor.imagem != null && _condutor.imagem.isNotEmpty
                      ? MemoryImage(base64Decode(_condutor.imagem))
                      : AssetImage("images/person.png"),
                ),
              ),
              child: null,
            ),
            ListTile(
              title: Text('Cadastrar Serviços'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => telaCadastro(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Atualizar Dados'),
              onTap: () async {
                final Condutor condutor = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => telaCadastro(
                      condutor: _condutor,
                    ),
                  ),
                );
                if (condutor != null) {
                  setState(() {
                    _condutor = condutor;
                  });
                }
              },
            ),
          ]).toList(),
        ),
      ),
      appBar: AppBar(
        title: Text(("Tela Principal")),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        onPressed: (){
          _showTelaLancamentos();
        },
      ),
      body: _buildListaLancamentos()
  );
  }
}