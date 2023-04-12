import '../infra/database/db_configuration.dart';
import '../models/entrega.dart';
import 'dao.dart';

class EntregaDAO implements DAO<Entrega> {
  final DBConfiguration _dbConfiguration;
  EntregaDAO(this._dbConfiguration);

  @override
  Future<int> create(Entrega value) async {
    var resultVenda = await _dbConfiguration.execQuery(
      'SELECT * FROM vendas WHERE id_venda = ?',
      [value.idVenda],
    );

    if (resultVenda.isEmpty) return 400;

    var result = await _dbConfiguration.execQuery(
      'INSERT INTO entregas (id_venda, data_prevista) VALUES (?, ?)',
      [value.idVenda, value.expectedDate!.toUtc()],
    );

    return result.affectedRows > 0 ? 200 : 500;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery(
      'DELETE FROM entregas WHERE id_entrega = ?',
      [id],
    );

    return result.affectedRows > 0;
  }

  @override
  Future<List<Entrega>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM entregas');

    return result
        .map((r) => Entrega.fromMap(r.fields))
        .toList()
        .cast<Entrega>();
  }

  @override
  Future<Entrega?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery(
      'SELECT * FROM entregas WHERE id_entrega = ?',
      [id],
    );

    return result.isEmpty ? null : Entrega.fromMap(result.first.fields);
  }

  @override
  Future<int> update(Entrega value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE entregas SET data_prevista = CASE WHEN ? THEN ? ELSE data_prevista END, data_entrega = CASE WHEN ? THEN ? ELSE data_prevista END WHERE id_entrega = ?',
      [value.expectedDate?.toUtc(), value.expectedDate?.toUtc(), value.deliveryDate?.toUtc(), value.deliveryDate?.toUtc(), value.id],
    );

    return result.affectedRows > 0 ? 200 : 500;
  }
}
