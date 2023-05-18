import '../DAO/category_dao.dart';
import '../models/category.dart';
import 'generic_service.dart';

class CategoryService implements GenericService<Category> {
  final CategoryDAO _categoryDAO;
  CategoryService(this._categoryDAO);

  @override
  Future<bool> delete(int id) async => await _categoryDAO.delete(id);

  @override
  Future<List<Category>> findAll() async => await _categoryDAO.findAll();

  @override
  Future<Category?> findOne(int id) async => await _categoryDAO.findOne(id);

  @override
  Future<dynamic> save(Category value) async {
    if (value.id != null) {
      return await _categoryDAO.update(value);
    } else {
      return await _categoryDAO.create(value);
    }
  }
}
