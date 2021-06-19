import 'package:flutter/material.dart';

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

  DateTime _data;

  Widget _buildIcon(){
    return Container(
      alignment: Alignment.center,
      child: Icon(
        Icons.monetization_on,
        size: 80.0,
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
          hint: Text('Selecione o serviço desejado'),
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
          hint: Text('Selecione <Entrada> ou <Saída>'),
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
      cursorColor: Colors.green,
      decoration: InputDecoration(
        labelText: 'Valor',
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        prefixText: 'R\$',),
      style: TextStyle(color: Colors.indigoAccent,),

      keyboardType: TextInputType.numberWithOptions(decimal:true),
    );
  }

  Widget _buildDescricao(){
    return TextField(
      cursorColor: Colors.green,
      decoration: InputDecoration(
          labelText: "Descrição",
          labelStyle: TextStyle(color: Colors.indigoAccent),
          border: OutlineInputBorder()
      ),
      style: TextStyle(color: Colors.indigoAccent,)
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lançamentos'),),
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
              //  SizedBox(height: 15),
              // _buildValor(),
              SizedBox(height: 15),
              //_buildDescricao(),
              // SizedBox(height: 15),

            ],
          ),
        ),
      )

    );
  }
}
