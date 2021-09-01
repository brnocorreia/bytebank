import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/web_client.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transferencia>>(
          future: Future.delayed(Duration(milliseconds: 500))
              .then((value) => findAll()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress(
                  message: "Loading Transactions",
                );
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transferencia>? transferencias = snapshot.data;
                  if (transferencias!.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transferencia transferencia =
                            transferencias[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.monetization_on),
                            title: Text(
                              transferencia.valor.toString(),
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transferencia.contato.numeroConta.toString(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: transferencias.length,
                    );
                  }
                }
                return CenteredMessage("No Transactions Found",
                    icon: Icons.warning);
            }
            return Text("Unknown Error");
          }),
    );
  }
}
