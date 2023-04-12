import '../infra/database/db_configuration.dart';
import '../models/planta.dart';
import 'dao.dart';

class PlantaDAO implements DAO<Planta> {
  final DBConfiguration _dbConfiguration;
  PlantaDAO(this._dbConfiguration);

  @override
  Future<int> create(Planta value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO plantas (nome, especie, descricao, preco, quantidade_em_estoque, id_fornecedor) VALUES (?, ?, ?, ?, ?, ?)',
      [value.name, value.species, value.description, value.price, value.amount, value.idFornecedor],
    );

    return result.affectedRows > 0 ? 200 : 400;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery(
      'DELETE FROM plantas WHERE id_planta = ?',
      [id],
    );

    return result.affectedRows > 0;
  }

  @override
  Future<List<Planta>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM plantas');

    return result.map((r) => Planta.fromMap(r.fields)).toList().cast<Planta>();
  }

  @override
  Future<Planta?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery(
      'SELECT * FROM plantas WHERE id_planta = ?',
      [id],
    );

    return result.isEmpty ? null : Planta.fromMap(result.first.fields);
  }

  @override
  Future<int> update(Planta value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE plantas SET descricao = CASE WHEN STRCMP(descricao, ?) THEN ? ELSE descricao END, preco = CASE WHEN ? THEN ? ELSE preco END, quantidade_em_estoque = CASE WHEN ? THEN ? ELSE quantidade_em_estoque END WHERE id_planta = ?',
      [
        value.description,
        value.description,
        value.price,
        value.price,
        value.amount,
        value.amount,
        value.id
      ],
    );

    return result.affectedRows > 0 ? 200 : 500;
  }
}
