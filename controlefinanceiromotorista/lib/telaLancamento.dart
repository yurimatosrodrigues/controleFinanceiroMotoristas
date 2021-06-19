import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';


class TelaLancamento extends StatefulWidget {
  @override
  _TelaLancamentoState createState() => _TelaLancamentoState();
}


class _TelaLancamentoState extends State<TelaLancamento> {
  List<String> service = ['Gasolina', 'Álcool', 'Corrida ETEC',
    'Corrida FATEC', 'Troca de óleo'];

  List<String> entradaSaida = ['Entrada', 'Saída'];

  String valueDropDownService;
  String valueDropDownEntradaSaida;

  final DateFormat _formatoData = DateFormat("dd/MM/yyyy");
  final Color _corInformacao = Colors.blueGrey;
  final Color _corValor = Colors.black;
  final Color _corTema = Colors.blueAccent;

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
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 5),
      width: 365, height: 60,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(7)
      ),
      child: DropdownButton(
          hint: Text('Selecione o serviço desejado',
            style: TextStyle(color: _corInformacao),),
          dropdownColor: Colors.grey.shade300,
          value: valueDropDownService,
          isExpanded: true,
          underline: SizedBox(),
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 34,
          onChanged: (String newValue) {
            setState(() {
              valueDropDownService = newValue;
            });
          },
          items: service
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Text(value));
          }).toList()
      ),
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
          hint: Text('Selecione <Entrada> ou <Saída>',
            style: TextStyle(color: _corInformacao)),
          dropdownColor: Colors.grey.shade300,
          value: valueDropDownEntradaSaida,
          isExpanded: true,
          underline: SizedBox(),
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 34,
          onChanged: (String newValue) {
            setState(() {
              valueDropDownEntradaSaida = newValue;
            });
          },
          items: entradaSaida
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
      cursorColor: _corTema,
      decoration: InputDecoration(
        labelText: 'Valor',
        labelStyle: TextStyle(color: _corInformacao),
        border: OutlineInputBorder(),
        prefixText: 'R\$',),
      style: TextStyle(color: _corValor,), //vermelho ou verde de acordo com a combo entrada/saida
      keyboardType: TextInputType.numberWithOptions(decimal:true),
    );
  }

  Widget _buildDescricao(){
    return TextField(
      cursorColor: _corTema,
      decoration: InputDecoration(
          labelText: "Descrição",
          labelStyle: TextStyle(color: _corInformacao),
          border: OutlineInputBorder()
      ),
      style: TextStyle(color: _corValor,)
    );
  }

  Widget _buildData(){
    return Container(
      child: DateTimeField(
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
          //print('teste');// _condutor.dataNascimento = date;
        });
      },
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lançamentos'), backgroundColor: _corTema,),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save)
      ),

      body: SingleChildScrollView(
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
    );
  }
}
