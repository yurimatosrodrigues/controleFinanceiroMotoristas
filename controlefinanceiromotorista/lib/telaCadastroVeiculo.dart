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

  String valueDropDownTipoVeiculo = 'Carro';
  String valueDropDownMarca = 'Chevrolet';
  String valueDropDownModelo = 'Onix';
  String valueDropDownCor = 'Branco';
  String valueDropDownCombustivel = 'Flex';

   final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));

  Widget _buildAnimacao(){
    return Container(
                width: 80,
                height: 80,
             /*   decoration: BoxDecoration(
                  color: Colors.green,
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: AssetImage('images/car.jpg')
                    )
                ),*/
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
  Widget _buildTipoVeiculo(){
    return DropdownButton(
      value: valueDropDownTipoVeiculo,
      icon: const Icon(Icons.arrow_downward),
      style: const TextStyle(color: Colors.indigoAccent),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      iconSize: 24,
      elevation: 16,
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
  }).toList());
  }
  Widget _buildMarca(){
    return DropdownButton(
      value: valueDropDownMarca,
      icon: const Icon(Icons.arrow_downward),
      style: const TextStyle(color: Colors.indigoAccent),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      iconSize: 24,
      elevation: 16,
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
    }).toList());
  }

  Widget _buildModelo(){
    return DropdownButton(
      value: valueDropDownModelo,
      icon: const Icon(Icons.arrow_downward),
      style: const TextStyle(color: Colors.indigoAccent),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      iconSize: 24,
      elevation: 16,
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
    }).toList());
  }
  Widget _buildCor(){
    return DropdownButton(
      value: valueDropDownCor,
      icon: const Icon(Icons.arrow_downward),
      style: const TextStyle(color: Colors.indigoAccent),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      iconSize: 24,
      elevation: 16,
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
  }).toList());
  }
  Widget _buildCombustivel(){
    return  DropdownButton(
      value: valueDropDownCombustivel,
      icon: const Icon(Icons.arrow_downward),
      style: const TextStyle(color: Colors.indigoAccent),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      iconSize: 24,
      elevation: 16,
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
  }).toList());
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
            crossAxisAlignment: CrossAxisAlignment.stretch,            

            children: <Widget>[
              _buildAnimacao(),
              _buildPlaca(),
              Divider(),
              _buildTipoVeiculo(),
              Divider(),

              Text('Marca'),
              _buildMarca(),

              Divider(),
              Text('Modelo'),
              _buildModelo(),
              Divider(),
              Text('Cor'),
              _buildCor(),
              Divider(),
              Text('Combustível'),
              _buildCombustivel(),
              Divider(),
              _buildAno(),
              Divider(),
              _buildMediaKM(),            

              ElevatedButton(
              style: style,
              onPressed: () {},
              child: const Text('Salvar'),              
              )
              
              ],

            ),
            )

          )

        )




    );
  }
}
