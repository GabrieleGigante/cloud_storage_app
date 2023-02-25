import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../cache/cache.dart';
import '../interfaces/crud_repository.dart';
import '../models/file.dart';

class FileRepository implements CrudRepository<File> {
  final Ref _ref;
  final Cache cache;

  FileRepository(this._ref) : cache = _ref.read(cacheProvider);

  @override
  Future<File> get(String id) async {
    final file = await cache.getFile(id);
    if (file != null) {
      return file;
    }
    return File();
  }

  @override
  Future<File?> store(File file) async {
    await cache.setFile(file);
    return file;
  }

  @override
  Future<File?> delete(String id) async {
    await cache.deleteFile(id);
    return null;
  }
}
