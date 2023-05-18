import '../infra/database/db_configuration.dart';
import '../models/address.dart';
import 'dao.dart';

class AddressDAO implements DAO<Address> {
  final DBConfiguration _dbConfiguration;
  AddressDAO(this._dbConfiguration);

  @override
  Future<Map<String, dynamic>> create(Address value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO addresses (street, number, complement, neighborhood, city, state, country, postal_code) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [
        value.street,
        value.number,
        value.complement,
        value.neighborhood,
        value.city,
        value.state,
        value.country,
        value.postalCode
      ],
    );

    return result.affectedRows > 0 ? {'id': result.insertId, 'statusCode': 200} : {'id': result.insertId, 'statusCode': 400};
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery(
      'DELETE FROM addresses WHERE  id = ?',
      [id],
    );

    return result.affectedRows > 0;
  }

  @override
  Future<List<Address>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM addresses');

    return result
        .map((r) => Address.fromMap(r.fields))
        .toList()
        .cast<Address>();
  }

  @override
  Future<Address?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery(
      'SELECT * FROM addresses WHERE id = ?',
      [id],
    );

    return result.isEmpty ? null : Address.fromMap(result.first.fields);
  }

  @override
  Future<int> update(Address value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE addresses SET street = IFNULL(?, street), number = IFNULL(?, number), complement = IFNULL(?, complement), neighborhood = IFNULL(?, neighborhood), city = IFNULL(?, city), state = IFNULL(?, state), country = IFNULL(?, country), postal_code = IFNULL(?, postal_code) WHERE id = ?',
      [
        value.street,
        value.number,
        value.complement,
        value.neighborhood,
        value.city,
        value.state,
        value.country,
        value.postalCode,
        value.id
      ],
    );

    return result.affectedRows > 0 ? 200 : 500;
  }
}
