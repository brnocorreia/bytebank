import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/contatos/formulario_contatos.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatefulWidget {
  // final List<Contato> contatos = [];

  State<StatefulWidget> createState() {
    return ListaContatosState();
  }
}

class ListaContatosState extends State<ListaContatos> {
  final ContatoDao _dao = ContatoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contacts",
        ),
      ),
      body: FutureBuilder<List<Contato>>(
          initialData: [],
          future: Future.delayed(Duration(milliseconds: 500))
              .then((value) => _dao.findAll()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress(message: "Loading Contacts");
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contato>? contatos = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contato contato = contatos![index];
                    return _ItemContato(contato);
                  },
                  itemCount: contatos!.length,
                );
            }
            return Text("Unknown Error");
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FormularioContatos()))
            .then((value) => setState(() {})),
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ItemContato extends StatelessWidget {
  final Contato contato;

  _ItemContato(this.contato);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contato.nome,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contato.numeroConta.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
