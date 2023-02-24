import 'package:cloud_storage/core/files/interfaces/crud_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../cache/cache.dart';
import '../models/folder.dart';

final folderRepositoryProvider = Provider((ref) => FolderRepository(ref));
final folderFromId = FutureProvider.family<Folder, String>((ref, id) async {
  final repo = ref.read(folderRepositoryProvider);
  return await repo.get(id);
});

class FolderRepository implements CrudRepository<Folder> {
  final Ref _ref;
  final Cache cache;

  FolderRepository(this._ref) : cache = _ref.read(cacheProvider);

  @override
  Future<Folder> get(String id) async {
    final f = await cache.getFolder(id);
    if (f != null) {
      return f;
    }
    return Folder();
  }

  @override
  Future<Folder?> store(Folder folder) async {
    await cache.setFolder(folder);
    return folder;
  }

  @override
  Future<Folder?> delete(String id) async {
    await cache.deleteFolder(id);
    return null;
  }
}
