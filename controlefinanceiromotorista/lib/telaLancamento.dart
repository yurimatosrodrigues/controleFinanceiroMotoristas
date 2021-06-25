import 'package:controlefinanceiromotorista/helper/lancamentoHelper.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'helper/servicoHelper.dart';

class TelaLancamento extends StatefulWidget {
  final Lancamento lancamento;
  final int idCondutor;

  TelaLancamento(this.idCondutor, {this.lancamento});

  @override
  _TelaLancamentoState createState() => _TelaLancamentoState();
}

class _TelaLancamentoState extends State<TelaLancamento> {
  ServicoHelper _servicoHelper = ServicoHelper();
  LancamentoHelper _lancamentoHelper = LancamentoHelper();
  Lancamento _lancamento = Lancamento();
  
  Future<List<Servico>> _futureServicos;
  List<Servico> _servicos = [];  
  List<String> _entradaSaida = ['Entrada', 'Saída'];
    
  Servico _valueDropDownService;  

  String _valueDropDownEntradaSaida;

  TextEditingController _valorController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _dataController = TextEditingController();

  bool _saving = false;  

  Color _corValor = Colors.black;

  final Color _corInformacao = Colors.blueGrey;  
  final Color _corTema = Colors.blueAccent;
  final DateFormat _formatoData = DateFormat("dd/MM/yyyy");

  final FocusNode _servicoFocus = FocusNode();  
  final FocusNode _entradaFocus = FocusNode();
  final FocusNode _valorFocus = FocusNode();
  final FocusNode _descricaoFocus = FocusNode();  

  void initState(){
    super.initState();
    _futureServicos = _servicoHelper.getServicos();
    

    if (widget.lancamento != null){      
      _lancamento = Lancamento.from(widget.lancamento.toMap());       
      _valueDropDownEntradaSaida = _lancamento.entrada == 1 ? 'Entrada' : 'Saída';
      _corValor = _lancamento.entrada == 1 ? Colors.green : Colors.red;
      _valorController.text = _lancamento.valor.toString();
      _descricaoController.text = _lancamento.descricao;
      _dataController.text = _formatoData.format(_lancamento.data);
    }
    else{    
    _lancamento = Lancamento();        
    }
    _lancamento.idCondutor = widget.idCondutor;
  }

  Widget _buildIcon(){
    return Container(
      alignment: Alignment.center,
      child: Icon(
        Icons.monetization_on,
        size: 90.0,
        color: Colors.green,
      ),
    );
  }

  Widget _buildService(){    
    return FutureBuilder<List<Servico>>(
      future: _futureServicos,
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Text('Carregando serviços...');
          default:
            if(snapshot.hasError){
              return Text('Erro ao carregar serviços.');
            }
            else{ 
              _servicos = snapshot.data;
              
              return Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                width: 365, height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(7)
                ),
                child: DropdownButton(                    
                  focusNode: _servicoFocus,                  
                  hint: Text('Selecione o serviço desejado',
                    style: TextStyle(color: _corInformacao),),
                  dropdownColor: Colors.grey.shade300,
                  value: _valueDropDownService,
                  isExpanded: true,
                  underline: SizedBox(),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 34,
                  onChanged: (Servico servico) {
                    if(servico != null){
                      setState(() {
                        _valueDropDownService = servico;
                        _lancamento.idServico = servico.id;
                    });
                    } 
                  }, 
                  items: _servicos
                      .map<DropdownMenuItem<Servico>>((Servico value) {
                        return DropdownMenuItem<Servico>(
                            value: (value),
                            child: Text(value.servico));
                  }).toList()
                ),
              );
            }
        }
      },
    );
  }

  Widget _buildEntradaSaida(){
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 5),
      width: 365, height: 60,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(7)
      ),
      child: DropdownButton(
        focusNode: _entradaFocus,      
        hint: Text('Selecione <Entrada> ou <Saída>',
          style: TextStyle(color: _corInformacao)),
        dropdownColor: Colors.grey.shade300,
        value: _valueDropDownEntradaSaida,
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 34,
        onChanged: (String newValue) {
          setState(() {              
            _valueDropDownEntradaSaida = newValue;
            if(newValue == 'Entrada'){
              _lancamento.entrada = 1;
              _corValor = Colors.green;
            }
            else{
              _lancamento.entrada = 0;
              _corValor = Colors.red;
            }
          });
        },
        items: _entradaSaida
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(value));
        }).toList()
      ),
    );
  }

  Widget _buildValor(){    
    return  TextField(
      controller: _valorController,
      focusNode: _valorFocus,
      cursorColor: _corTema,
      decoration: InputDecoration(
        labelText: 'Valor',
        labelStyle: TextStyle(color: _corInformacao),
        border: OutlineInputBorder(),
        prefixText: 'R\$',),
      style: TextStyle(color: _corValor,),
      keyboardType: TextInputType.numberWithOptions(decimal:true),
      onChanged: (text){
        setState((){
          _lancamento.valor = double.tryParse(text).abs();
        });
      },
    );
  }

  Widget _buildDescricao(){
    return TextField(      
      controller: _descricaoController,
      focusNode: _descricaoFocus,
      cursorColor: _corTema,
      decoration: InputDecoration(
          labelText: "Descrição",
          labelStyle: TextStyle(color: _corInformacao),
          border: OutlineInputBorder()
      ),
      style: TextStyle(color: Colors.black,),
      onChanged: (text){
        setState((){
          _lancamento.descricao = text;
        });
      },
    );
  }

  Widget _buildData(){
    return Container(
      child: DateTimeField(
      controller: _dataController,      
      decoration: InputDecoration(
          labelText: 'Data da realização do serviço'),
      format: _formatoData,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(2021),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime.now());
      },
      onChanged: (date) {
        setState(() {
          _lancamento.data = date;
        });
      },
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lançamentos'), backgroundColor: _corTema,),

      floatingActionButton: FloatingActionButton.extended(        
        label: Text('Salvar'),
        onPressed: (){          
           _saveLancamento();
        }),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(12.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildIcon(),
              SizedBox(height: 15), 
              _buildService(),
              SizedBox(height: 15),
              _buildEntradaSaida(),
              SizedBox(height: 15),
              _buildValor(),
              SizedBox(height: 15),
              _buildDescricao(),
              SizedBox(height: 15),
              _buildData()
            ],
          ),
        ),
      )
      )
    );
  }

  void _saveLancamento(){
    if (_lancamento.idServico == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Um serviço deve ser selecionado."),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_servicoFocus);
      return;
    }
    if (_lancamento.entrada == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Informe se é uma receita (Entrada) ou despesa (Saída)."),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_entradaFocus);
      return;
    }
    if (_lancamento.valor == null || _lancamento.valor == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Informe um valor válido."),
        duration: new Duration(seconds: 1),
      ));
      FocusScope.of(context).requestFocus(_valorFocus);
      return;
    }       
    if (_lancamento.data == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("A data do lançamento deve ser informada."),
        duration: new Duration(seconds: 1),
      ));     
      return;
    }

    if (_lancamento.descricao == null || _lancamento.descricao.isEmpty) {
      _lancamento.descricao = '-';       
    }  

    setState(() {      
      _saving = true;
    });
    _lancamentoHelper.saveLancamento(_lancamento).then((value) {
      setState(() {
        _saving = false;
      });
      Navigator.pop(context, _lancamento);
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
