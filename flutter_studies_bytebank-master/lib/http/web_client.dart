import 'dart:convert';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print("Request");
    print("url: ${data.url}");
    print("headers: ${data.headers}");
    print("body: ${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("Response");
    print("status code: ${data.statusCode}");
    print("headers: ${data.headers}");
    print("body: ${data.body}");
    return data;
  }
}

Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

Future<List<Transferencia>> findAll() async {
  final Response response = await client
      .get(Uri.http('192.168.0.108:8080', 'transactions'))
      .timeout(Duration(seconds: 10));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transferencia> transferencias = [];
  for (Map<String, dynamic> transferenciaJson in decodedJson) {
    final Map<String, dynamic> contatoJson = transferenciaJson['contact'];
    final Transferencia transferencia = Transferencia(
      transferenciaJson['value'],
      Contato(
        0,
        contatoJson['name'],
        contatoJson['accountNumber'],
      ),
    );
    transferencias.add(transferencia);
  }
  return transferencias;
}

Future<Transferencia> save(Transferencia transferencia) async {
  final Map<String, dynamic> transactionMap = {
    'value': transferencia.valor,
    'contact': {
      'name': transferencia.contato.nome,
      'accountNumber': transferencia.contato.numeroConta
    }
  };

  final String transferenciaJson = jsonEncode(transactionMap);

  final Response response =
      await client.post(Uri.http('192.168.0.108:8080', 'transactions'),
          headers: {
            'Content-type': 'application/json',
            'password': '1000',
          },
          body: transferenciaJson);
  Map<String, dynamic> json = jsonDecode(response.body);
  final Map<String, dynamic> contatoJson = json['contact'];
  return Transferencia(
    json['value'],
    Contato(
      0,
      contatoJson['name'],
      contatoJson['accountNumber'],
    ),
  );
}
