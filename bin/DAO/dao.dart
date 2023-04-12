
abstract class DAO<T> {
  Future<T?> findOne(int id);
  Future<List<T>> findAll();
  Future<int> create(T value);
  Future<int> update(T value);
  Future<bool> delete(int id);
}