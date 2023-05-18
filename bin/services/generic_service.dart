abstract class GenericService<T> {
  Future<T?> findOne(int id);
  Future<List<T>> findAll();
  Future<dynamic> save(T value);
  Future<bool> delete(int id);
}
