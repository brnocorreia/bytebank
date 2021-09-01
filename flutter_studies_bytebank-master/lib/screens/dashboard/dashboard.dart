import 'package:bytebank/screens/contatos/lista_contatos.dart';
import 'package:bytebank/screens/transferencia/lista_transferencia.dart';
import 'package:flutter/material.dart';

class DashboardInicial extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardInicialState();
  }
}

class DashboardInicialState extends State<DashboardInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(60.0),
                    child: Image.asset("images/bytebank_logo.png")),
              ),
              Container(
                height: 120.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Botao(
                      "Contacts",
                      Icons.people,
                      onClick: () {
                        _showListaContatos(context);
                      },
                    ),
                    Botao("Transfer Feed", Icons.description, onClick: () {
                      _showListaTransferencias(context);
                    }),
                    Botao("My Balance", Icons.account_balance, onClick: () {
                      print("My Balance was clicked");
                    }),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _showListaContatos(BuildContext context) {
    Navigator.of(context).push(
      (MaterialPageRoute(
        builder: (context) => ListaContatos(),
      )),
    );
  }

  void _showListaTransferencias(BuildContext context) {
    Navigator.of(context).push(
      (MaterialPageRoute(
        builder: (context) => ListaTransferencias(),
      )),
    );
  }

  // void _showSaldo(BuildContext context) {
  //   Navigator.of(context).push(
  //     (MaterialPageRoute(
  //       builder: (context) => ListaSaldo(),
  //     )),
  //   );
  // }
}

class Botao extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  Botao(this.name, this.icon, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 150.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
