import '../infra/database/db_configuration.dart';
import '../models/order.dart';
import 'dao.dart';

class OrderDAO implements DAO<Order> {
  final DBConfiguration _dbConfiguration;
  OrderDAO(this._dbConfiguration);

  @override
  Future<Map<String, dynamic>> create(Order value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO orders (product_id, amount, total_price, shipping_address_id, expected_date, delivery_date, status) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [
        value.productId,
        value.amount,
        value.totalPrice,
        value.shippingAddressId,
        value.expectedDate,
        value.deliveryDate,
        value.status
      ],
    );

    return result.affectedRows > 0 ? {'id': result.insertId, 'statusCode': 200} : {'id': result.insertId, 'statusCode': 400};
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery(
      'DELETE FROM orders WHERE  id = ?',
      [id],
    );

    return result.affectedRows > 0;
  }

  @override
  Future<List<Order>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM orders');

    return result
        .map((r) => Order.fromMap(r.fields))
        .toList()
        .cast<Order>();
  }

  @override
  Future<Order?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery(
      'SELECT * FROM orders WHERE id = ?',
      [id],
    );

    return result.isEmpty ? null : Order.fromMap(result.first.fields);
  }

  @override
  Future<int> update(Order value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE orders SET product_id = IFNULL(?, product_id), amount = IFNULL(?, amount), total_price = IFNULL(?, total_price), shipping_address_id = IFNULL(?, shipping_address_id), expected_date = IFNULL(?, expected_date), delivery_date = IFNULL(?, delivery_date), status = IFNULL(?, status) WHERE id = ?',
      [
        value.productId,
        value.amount,
        value.totalPrice,
        value.shippingAddressId,
        value.expectedDate,
        value.deliveryDate,
        value.status,
        value.id
      ],
    );
    
    return result.affectedRows > 0 ? 200 : 500;
  }
}
