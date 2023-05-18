
import '../infra/database/db_configuration.dart';
import '../models/supplier.dart';
import 'dao.dart';

class SupplierDAO implements DAO<Supplier> {
  final DBConfiguration _dbConfiguration;
  SupplierDAO(this._dbConfiguration);

  @override
  Future<Map<String, dynamic>> create(Supplier value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO suppliers (name, address_id, email, phone) VALUES (?, ?, ?, ?)',
      [
        value.name,
        value.addressId,
        value.email,
        value.phone
      ],
    );

    return result.affectedRows > 0 ? {'id': result.insertId, 'statusCode': 200} : {'id': result.insertId, 'statusCode': 400};
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery(
      'DELETE FROM suppliers WHERE  id = ?',
      [id],
    );

    return result.affectedRows > 0;
  }

  @override
  Future<List<Supplier>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM suppliers');

    return result
        .map((r) => Supplier.fromMap(r.fields))
        .toList()
        .cast<Supplier>();
  }

  @override
  Future<Supplier?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery(
      'SELECT * FROM suppliers WHERE id = ?',
      [id],
    );

    return result.isEmpty ? null : Supplier.fromMap(result.first.fields);
  }

  @override
  Future<int> update(Supplier value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE suppliers SET name = IFNULL(?, name), address_id = IFNULL(?, address_id), email = IFNULL(?, email), phone = IFNULL(?, phone) WHERE id = ?',
      [
        value.name,
        value.addressId,
        value.email,
        value.phone,
        value.id
      ],
    );
    
    return result.affectedRows > 0 ? 200 : 500;
  }

}