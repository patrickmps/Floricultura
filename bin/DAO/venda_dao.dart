import '../infra/database/db_configuration.dart';
import '../models/venda.dart';
import 'dao.dart';

class VendaDAO implements DAO<Venda> {
  final DBConfiguration _dbConfiguration;
  VendaDAO(this._dbConfiguration);

  @override
  Future<int> create(Venda value) async {
    var resultPlanta = await _dbConfiguration.execQuery(
      'UPDATE plantas SET quantidade_em_estoque = quantidade_em_estoque - ?  WHERE id_planta = ? AND quantidade_em_estoque - ? > 0',
      [value.amount, value.idPlanta, value.amount],
    );

    if (resultPlanta.affectedRows <= 0) return 400;

    var result = await _dbConfiguration.execQuery(
      'INSERT INTO vendas (id_planta, quantidade, valor_total) VALUES (?, ?, ?)',
      [value.idPlanta, value.amount, value.value],
    );

    return result.affectedRows > 0 ? 200 : 500;
  }

  @override
  Future<bool> delete(int id) async {
    return false;
  }

  @override
  Future<List<Venda>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM vendas');

    return result.map((r) => Venda.fromMap(r.fields)).toList().cast<Venda>();
  }

  @override
  Future<Venda?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery(
      'SELECT * FROM vendas WHERE id_venda = ?',
      [id],
    );

    return result.isEmpty ? null : Venda.fromMap(result.first.fields);
  }

  @override
  Future<int> update(Venda value) async {
    return 500;
  }
}
