class CrudRepository<T> {
  Future<T> get(String id) => throw UnimplementedError();
  Future<T?> store(T element) => throw UnimplementedError();
  Future<T?> delete(String id) => throw UnimplementedError();
}
