import 'package:bytebank/models/contato.dart';
import 'package:sqflite/sqflite.dart';
import '../app_database.dart';

class ContatoDao {
  static const String tableSql = "CREATE TABLE $_tableName("
      "$_id INTEGER PRIMARY KEY, "
      "$_nome TEXT, "
      "$_numeroconta INTEGER)";

  static const String _tableName = "contatos";
  static const String _id = "id";
  static const String _nome = "nome";
  static const String _numeroconta = "numero_conta";

  Future<int> save(Contato contato) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contatoMap = _toMap(contato);
    return db.insert(_tableName, contatoMap);
  }

  Map<String, dynamic> _toMap(Contato contato) {
    final Map<String, dynamic> contatoMap = Map();
    contatoMap[_nome] = contato.nome;
    contatoMap[_numeroconta] = contato.numeroConta;
    return contatoMap;
  }

  Future<List<Contato>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contato> contatos = _toList(result);
    return contatos;
  }

  Future<int> update(Contato contato) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> contatoMap = _toMap(contato);
    return db.update(
      _tableName,
      contatoMap,
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  List<Contato> _toList(List<Map<String, dynamic>> result) {
    final List<Contato> contatos = [];
    for (Map<String, dynamic> row in result) {
      final Contato contato = Contato(
        row[_id],
        row[_nome],
        row[_numeroconta],
      );
      contatos.add(contato);
    }
    return contatos;
  }
}
