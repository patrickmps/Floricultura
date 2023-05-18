import '../infra/database/db_configuration.dart';
import '../models/product.dart';
import 'dao.dart';

class ProductDAO implements DAO<Product> {
  final DBConfiguration _dbConfiguration;
  ProductDAO(this._dbConfiguration);

  @override
  Future<Map<String, dynamic>> create(Product value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO products (name, description, price, amount, category_id, supplier_id) VALUES (?, ?, ?, ?, ?, ?)',
      [
        value.name,
        value.description,
        value.price,
        value.amount,
        value.categoryId,
        value.supplierId
      ],
    );

    return result.affectedRows > 0 ? {'id': result.insertId, 'statusCode': 200} : {'id': result.insertId, 'statusCode': 400};
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery(
      'DELETE FROM products WHERE  id = ?',
      [id],
    );

    return result.affectedRows > 0;
  }

  @override
  Future<List<Product>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM products');

    return result
        .map((r) => Product.fromMap(r.fields))
        .toList()
        .cast<Product>();
  }

  @override
  Future<Product?> findOne(dynamic id) async {
    var result = await _dbConfiguration.execQuery(
      'SELECT * FROM products WHERE id = ?',
      [id],
    );

    return result.isEmpty ? null : Product.fromMap(result.first.fields);
  }

  @override
  Future<int> update(Product value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE products SET name = IFNULL(?, name), description = IFNULL(?, description), price = IFNULL(?, price), amount = IFNULL(?, amount), category_id = IFNULL(?, category_id), supplier_id = IFNULL(?, supplier_id) WHERE id = ?',
      [
        value.name,
        value.description,
        value.price,
        value.amount,
        value.categoryId,
        value.supplierId,
        value.id
      ],
    );
    
    return result.affectedRows > 0 ? 200 : 500;
  }
}
