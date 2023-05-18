
abstract class DAO<T> {
  Future<T?> findOne(int id);
  Future<List<T>> findAll();
  Future<Map<String, dynamic>> create(T value);
  Future<int> update(T value);
  Future<bool> delete(int id);
}