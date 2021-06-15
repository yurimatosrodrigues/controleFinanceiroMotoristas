import 'package:controlefinanceiromotorista/telaCadastro.dart';
import 'package:flutter/material.dart';

class telaPrincipal extends StatefulWidget {
  @override
  _telaPrincipalState createState() => _telaPrincipalState();
}

class _telaPrincipalState extends State<telaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Criação do MENU
      drawer: Drawer(
        child: ListView(
          children: ListTile.divideTiles(
              context: context,
              tiles: [
                DrawerHeader(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage("images/person.png"),

                      )),
                ),

                ListTile(
                  title: Text('Cadastrar Serviços'),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  telaCadastro())
                    );
                  },
                ),

                ListTile(
                  title: Text('Atualizar Dados'),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => telaCadastro())
                    );
                  },
                ),
              ]
          ).toList(),
        ),
      ),

      appBar: AppBar(
        title: Text(("Tela Principal")),
      ),

      body: Container(

      ),
    );
  }
}
