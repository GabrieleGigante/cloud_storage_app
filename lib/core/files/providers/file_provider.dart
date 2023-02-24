import 'package:cloud_storage/core/cache/cache.dart';
import 'package:cloud_storage/core/files/interfaces/crud_repository.dart';
import 'package:dog/dog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/file.dart';

final fileRepositoryProvider = Provider<FileRepository>((ref) => FileRepository(ref));
final fileFromId = FutureProvider.family<File, String>((ref, id) async {
  final repo = ref.read(fileRepositoryProvider);
  return repo.get(id);
});

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
