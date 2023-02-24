import 'package:cloud_storage/core/files/interfaces/crud_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../cache/cache.dart';
import '../models/folder.dart';
import '../repositories/folder_respository.dart';

final folderRepositoryProvider = Provider((ref) => FolderRepository(ref));
// final folderFromId = FutureProvider.family<Folder, String>((ref, id) async {
//   final repo = ref.read(folderRepositoryProvider);
//   return await repo.get(id);
// });

final folderFromId = StateNotifierProviderFamily<FolderNotifier, AsyncValue<Folder>, String>(
    (ref, String id) => FolderNotifier(ref, id));

class FolderNotifier extends StateNotifier<AsyncValue<Folder>> {
  final Ref _ref;
  final String id;
  final FolderRepository repo;

  FolderNotifier(this._ref, this.id)
      : repo = _ref.read(folderRepositoryProvider),
        super(const AsyncLoading()) {
    get();
  }

  Future<void> get() async {
    state = const AsyncLoading();
    try {
      state = AsyncData(await repo.get(id));
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> store(Folder folder) async {
    try {
      await repo.store(folder);
      state = AsyncData(folder);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
