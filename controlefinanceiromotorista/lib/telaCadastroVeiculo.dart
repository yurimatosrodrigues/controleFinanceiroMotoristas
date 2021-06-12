import 'package:flutter/material.dart';

class TelaCadastroVeiculo extends StatefulWidget {
  @override
  _TelaCadastroVeiculoState createState() => _TelaCadastroVeiculoState();
}

class _TelaCadastroVeiculoState extends State<TelaCadastroVeiculo> {
  List<String> tipoVeiculo = ['Carro', 'Moto'];
  List<String> marcaVeiculo = ['Audi', 'BMW', 'Chevrolet', 'Fiat', 'Ford', 'Renault'];
  List<String> modeloVeiculo = ['Onix', 'Prisma', 'Chevrolet', 'Cruze', 'Spin'];
  List<String> corVeiculo = ['Branco', 'Preto', 'Cinza', 'Azul', 'Vermelho'];
  List<String> tipoCombustivel = ['Álcool', 'Gás', 'Gasolina', 'Flex'];

  String valueDropDownTipoVeiculo;
  String valueDropDownMarca;
  String valueDropDownModelo;
  String valueDropDownCor;
  String valueDropDownCombustivel;

   final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));

  Widget _buildAnimacao(){
    return Container(      
      width: 350,
      height: 70,        
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,                
        image: DecorationImage(image: AssetImage('images/car.png'))
      ),
    );
  }  

  Widget _buildTipoVeiculo(){
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 5),
      width: 365, height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(7)
      ),
      child: DropdownButton(
        hint: Text('Selecione o tipo do veículo'),
        dropdownColor: Colors.grey.shade300,
        value: valueDropDownTipoVeiculo,
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 34,
        onChanged: (String newValue) {
          setState(() {
            valueDropDownTipoVeiculo = newValue;
          });
        },
        items: tipoVeiculo
        .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(value));
          }).toList()
      ),
    );
  }

  Widget _buildMarca(){
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 5),
      width: 365, height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(7)
      ),
      child: DropdownButton(
        hint: Text('Selecione a marca'),
        dropdownColor: Colors.grey.shade300,
        value: valueDropDownMarca,
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 34,
        onChanged: (String newValue) {
          setState(() {
            valueDropDownMarca = newValue;
          });
        },
        items: marcaVeiculo
        .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(value));
          }).toList()
      ),
    );
  }

  Widget _buildModelo(){
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 5),
      width: 365, height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(7)
      ),
      child: DropdownButton(
        hint: Text('Selecione o modelo'),
        dropdownColor: Colors.grey.shade300,
        value: valueDropDownModelo,
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 34,
        onChanged: (String newValue) {
          setState(() {
            valueDropDownModelo = newValue;
          });
        },
        items: modeloVeiculo
        .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(value));
          }).toList()
      ),
    );
  }
  
  Widget _buildCor(){
     return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 5),
      width: 365, height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(7)
      ),
      child: DropdownButton(
        hint: Text('Selecione a cor'),
        dropdownColor: Colors.grey.shade300,
        value: valueDropDownCor,
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 34,
        onChanged: (String newValue) {
          setState(() {
            valueDropDownCor = newValue;
          });
        },
        items: corVeiculo
        .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(value));
          }).toList()
      ),
    );    
  }

  Widget _buildCombustivel(){
     return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 5),
      width: 365, height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(7)
      ),
      child: DropdownButton(
        hint: Text('Selecione o tipo de combustível'),
        dropdownColor: Colors.grey.shade300,
        value: valueDropDownCombustivel,
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 34,
        onChanged: (String newValue) {
          setState(() {
            valueDropDownCombustivel = newValue;
          });
        },
        items: tipoCombustivel
        .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(value));
          }).toList()
      ),
    );
  }

  Widget _buildPlaca(){
    return TextField(      
      decoration: InputDecoration(
          labelText: "Placa",
          labelStyle: TextStyle(color: Colors.indigoAccent),
          border: OutlineInputBorder()
      ),
      style: TextStyle(color: Colors.black),
    );
  }

  Widget _buildAno(){
    return TextField(              
      decoration: InputDecoration(
          labelText: "Ano",
          labelStyle: TextStyle(color: Colors.indigoAccent),
          border: OutlineInputBorder()
      ),
      style: TextStyle(color: Colors.black),
    );
  }

  Widget _buildMediaKM(){
    return TextField(
      decoration: InputDecoration(
          labelText: "Média KM/L",
          labelStyle: TextStyle(color: Colors.indigoAccent),
          border: OutlineInputBorder()
      ),
      style: TextStyle(color: Colors.black),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Preencha os dados do veículo'),
          backgroundColor: Colors.indigoAccent,
          centerTitle: true,
        ),


        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(12.5),            
            child: Form(              
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,            

            children: <Widget>[
              _buildAnimacao(),              
              SizedBox(height: 15),
              _buildTipoVeiculo(),              
              SizedBox(height: 15),              
              _buildMarca(),
              SizedBox(height: 15),              
              _buildModelo(),
              SizedBox(height: 15),              
              _buildCor(),
              SizedBox(height: 15),              
              _buildCombustivel(),
              SizedBox(height: 15),              
              _buildPlaca(),
              SizedBox(height: 15),
              _buildAno(),
              SizedBox(height: 15),
              _buildMediaKM(),              
              SizedBox(height: 15),

              Container(  
                alignment: Alignment.bottomCenter,
                width: 140,
                height: 40,
                child: ElevatedButton(
                  style: style,
                  onPressed: () {},
                  child: const Text('Salvar'),              
              ),
              )

              
              ],

            ),
            )

          )

        )




    );
  }
}
