import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../api/v1.dart';
import '../models/file.dart';
import '../models/folder.dart';
import '../services/extension_to_mime.dart';

// final folderRepositoryProvider = Provider((ref) => FolderRepository(ref));

final folderFromId = StateNotifierProviderFamily<FolderNotifier, AsyncValue<Folder>, String>(
    (ref, String id) => FolderNotifier(id));

class FolderNotifier extends StateNotifier<AsyncValue<Folder>> {
  final String folderId;

  FolderNotifier(this.folderId) : super(const AsyncLoading()) {
    getFolder();
  }

  Future<void> getFolder() async {
    state = const AsyncLoading();
    try {
      final folder = await API.getFolder(folderId);
      state = AsyncData(folder);
    } catch (e, stack) {
      print(stack);
      state = AsyncError(e, stack);
    }
  }

  Future<void> storeFolder(Folder folder) async {
    try {
      await API.setFolder(folder);
      if (folder.parentDirectory == folderId) {
        final currentFolder = state.asData?.value;
        if (currentFolder == null) {
          return;
        }
        state = AsyncData(currentFolder.copyWith(folders: [...currentFolder.folders, folder]));
      }
    } catch (e, stack) {
      print(stack);
      state = AsyncError(e, stack);
    }
  }

  Future<void> deleteFolder(String id) async {
    try {
      final currentFolder = state.asData?.value;
      if (currentFolder == null) {
        return;
      }
      if (currentFolder.folders.where((e) => e.id == id).isNotEmpty) {
        await API.deleteFolder(id);
        state = AsyncData(currentFolder.copyWith(
            folders: currentFolder.folders.where((e) => e.id != id).toList()));
      }
    } catch (e, stack) {
      print(stack);
      state = AsyncError(e, stack);
    }
  }

  Future<bool> uploadFile(PlatformFile file) async {
    try {
      final File resFile = await API.uploadFile(file, folderId);
      final currentFolder = state.asData?.value;
      if (currentFolder == null) {
        return true;
      }
      state = AsyncData(currentFolder.copyWith(files: [...currentFolder.files, resFile]));
      return false;
    } catch (e, stack) {
      print(e);
      print(stack);
      return true;
    }
  }
}
