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
  
   void _getTodosLancamentos(){
    setState((){
      _futureLancamentos = _lancamentoHelper.getLancamentoByCondutor(_condutor.id);
      _buildListaLancamentos();
    });
  }

  void _showTelaLancamentos({Lancamento lancamento}) async{    
    final _recLancamento = await Navigator.push(context, 
      MaterialPageRoute(builder: (context) => TelaLancamento(_condutor.id, lancamento: lancamento)));        
    _getTodosLancamentos();    
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
              _lancamentos.sort((a, b) => a.data.compareTo(b.data));
              
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

  void _showOptions(BuildContext context, int index){
    showModalBottomSheet(context: context, 
    builder: (context){
      return BottomSheet(onClosing: (){}, 
        builder: (context){
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextButton(
                    child: Text('Editar',
                    style: TextStyle(color: Colors.lightBlueAccent,
                    fontSize: 20),
                    
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                      _showTelaLancamentos(lancamento: _lancamentos[index]);
                    },
                  )
                ),

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextButton(
                    child: Text('Excluir',
                    style: TextStyle(color: Colors.red,
                    fontSize: 20),                    
                    ),
                    onPressed: (){
                      _lancamentoHelper.deleteLancamento(_lancamentos[index]);
                        setState(() {
                          _lancamentos.removeAt(index);
                          Navigator.pop(context);
                        });
                    },
                  )
                )
              ],
            ),
          );
        });

    });
  }

  Widget _buildCardLancamento(context, index){
    return GestureDetector(
      onTap: (){
        _showOptions(context,index);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Container(         
                width: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatoData.format(_lancamentos[index].data),
                      style: TextStyle(
                        fontSize: 15.0
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
                padding: EdgeInsets.only(left: 100),
                alignment: Alignment.center,
                child: Text(
                  'R\$ ' + _lancamentos[index].valor.toString(),
                  style: TextStyle(
                        fontSize: 30.0,
                        color: _lancamentos[index].entrada == 1 ? 
                          Colors.green : 
                          Colors.red
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