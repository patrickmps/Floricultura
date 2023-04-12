import '../infra/database/db_configuration.dart';
import '../models/fornecedor.dart';
import 'dao.dart';

class FornecedorDAO implements DAO<Fornecedor> {
  final DBConfiguration _dbConfiguration;
  FornecedorDAO(this._dbConfiguration);

  @override
  Future<int> create(Fornecedor value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO fornecedores (nome, endereco, telefone) VALUES (?, ?, ?)',
      [value.name, value.address, value.phone],
    );

    return result.affectedRows > 0 ? 200 : 404;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery(
      'DELETE FROM fornecedores WHERE id_fornecedor = ?',
      [id],
    );

    return result.affectedRows > 0;
  }

  @override
  Future<List<Fornecedor>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM fornecedores');

    return result.map((r) => Fornecedor.fromMap(r.fields)).toList().cast<Fornecedor>();
  }

  @override
  Future<Fornecedor?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery(
      'SELECT * FROM fornecedores WHERE id_fornecedor = ?',
      [id],
    );

    return result.affectedRows == 0
        ? null
        : Fornecedor.fromMap(result.first.fields);
  }

  @override
  Future<int> update(Fornecedor value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE fornecedores SET endereco = ?, telefone = ?  WHERE id_fornecedor = ?',
      [value.address, value.phone, value.id],
    );

    return result.affectedRows > 0 ? 200 : 500;
  }
}
