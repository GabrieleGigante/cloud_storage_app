import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../cache/cache.dart';
import '../interfaces/crud_repository.dart';
import '../models/folder.dart';

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
    return Folder(folders: [], files: []);
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
