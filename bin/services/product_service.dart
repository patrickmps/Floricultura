import '../models/product.dart';
import '../DAO/product_dao.dart';
import 'generic_service.dart';

class ProductService implements GenericService<Product> {
  final ProductDAO _productDAO;
  ProductService(this._productDAO);

  @override
  Future<bool> delete(int id) async => await _productDAO.delete(id);

  @override
  Future<List<Product>> findAll() async => await _productDAO.findAll();

  @override
  Future<Product?> findOne(int id) async => await _productDAO.findOne(id);

  @override
  Future<dynamic> save(Product value) async {
    if (value.id != null) {
      return await _productDAO.update(value);
    } else {
      return await _productDAO.create(value);
    }
  }
}
