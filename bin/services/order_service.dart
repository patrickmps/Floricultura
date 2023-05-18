
import '../DAO/order_dao.dart';
import '../models/order.dart';
import 'generic_service.dart';

class OrderService implements GenericService<Order> {
  final OrderDAO _orderDAO;
  OrderService(this._orderDAO);

  @override
  Future<bool> delete(int id) async => await _orderDAO.delete(id);

  @override
  Future<List<Order>> findAll() async => await _orderDAO.findAll();

  @override
  Future<Order?> findOne(int id) async => await _orderDAO.findOne(id);

  @override
  Future<dynamic> save(Order value) async {
    if (value.id != null) {
      return await _orderDAO.update(value);
    } else {
      return await _orderDAO.create(value);
    }
  }
}
