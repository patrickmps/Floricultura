import '../infra/database/db_configuration.dart';
import '../models/category.dart';
import 'dao.dart';

class CategoryDAO implements DAO<Category> {
  final DBConfiguration _dbConfiguration;
  CategoryDAO(this._dbConfiguration);

  @override
  Future<Map<String, dynamic>> create(Category value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO categories (category) VALUES (?)',
      [
        value.category,
      ],
    );

    return result.affectedRows > 0 ? {'id': result.insertId, 'statusCode': 200} : {'id': result.insertId, 'statusCode': 400};
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery(
      'DELETE FROM categories WHERE  id = ?',
      [id],
    );

    return result.affectedRows > 0;
  }

  @override
  Future<List<Category>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM categories');

    return result
        .map((r) => Category.fromMap(r.fields))
        .toList()
        .cast<Category>();
  }

  @override
  Future<Category?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery(
      'SELECT * FROM categories WHERE id = ?',
      [id],
    );

    return result.isEmpty ? null : Category.fromMap(result.first.fields);
  }

  @override
  Future<int> update(Category value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE categories SET category = IFNULL(?, category) WHERE id = ?',
      [value.category, value.id],
    );

    return result.affectedRows > 0 ? 200 : 500;
  }
}
