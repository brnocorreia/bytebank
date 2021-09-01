// import 'package:bytebank/database/app_database.dart';
// import 'package:bytebank/database/app_database.dart';
// ignore: unused_import
import 'package:bytebank/models/contato.dart';
// ignore: unused_import
import 'package:bytebank/models/transferencia.dart';
// ignore: unused_import
import 'package:bytebank/http/web_client.dart';
// import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
// import 'package:bytebank/models/contato.dart';

void main() {
  runApp(BytebankApp());
}

// saveTransfer(Transferencia(1, 100.0, 1000)).then((id) {
//     findAllTransfer()
//         .then((transferencias) => debugPrint(transferencias.toString()));
//   });

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.greenAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.greenAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: DashboardInicial());
  }
}
