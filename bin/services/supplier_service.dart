import '../DAO/supplier_dao.dart';
import '../models/supplier.dart';
import 'generic_service.dart';

class SupplierService implements GenericService<Supplier> {
  final SupplierDAO _supplierDAO;
  SupplierService(this._supplierDAO);

  @override
  Future<bool> delete(int id) async => await _supplierDAO.delete(id);

  @override
  Future<List<Supplier>> findAll() async => await _supplierDAO.findAll();

  @override
  Future<Supplier?> findOne(int id) async => await _supplierDAO.findOne(id);

  @override
  Future<dynamic> save(Supplier value) async {
    if (value.id != null) {
      return await _supplierDAO.update(value);
    } else {
      return await _supplierDAO.create(value);
    }
  }
}
