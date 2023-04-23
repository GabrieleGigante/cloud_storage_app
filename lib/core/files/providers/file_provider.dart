import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/file.dart';
import '../repositories/file_repository.dart';

// final fileRepositoryProvider = Provider<FileRepository>((ref) => FileRepository(ref));
// final fileFromId = FutureProvider.family<File, String>((ref, id) async {
//   final repo = ref.read(fileRepositoryProvider);
//   return repo.get(id);
// });

final fileFromId = StateNotifierProvider.family<FileNotifier, AsyncValue<File>, String>(
    (ref, String id) => FileNotifier(ref, id));

class FileNotifier extends StateNotifier<AsyncValue<File>> {
  final String fileId;
  final StateNotifierProviderRef<FileNotifier, AsyncValue<File>> ref;

  FileNotifier(this.ref, this.fileId) : super(const AsyncLoading()) {
    // get();
  }

  // Future<void> get() async {
  // state = const AsyncLoading();
  // try {
  //   final file = await API.getFile(fileId);
  //   state = AsyncData(file);
  // } catch (e, stack) {
  //   print(stack);
  //   state = AsyncError(e, stack);
  // }
  // }

  // Future<void> store(File file) async {
  // try {
  //   await API.setFile(file);
  //   if (file.parentDirectory == fileId) {
  //     final currentFile = state.asData?.value;
  //     if (currentFile == null) {
  //       return;
  //     }
  //     state = AsyncData(currentFile.copyWith(files: [...currentFile.files, file]));
  //   }
  // } catch (e, stack) {
  //   print(stack);
  //   state = AsyncError(e, stack);
  // }
  // }

  // Future<void> delete(String id) async {
  //   try {
  //     final currentFile = state.asData?.value;
  //     if (currentFile == null) {
  //       return;
  //     }
  //     if (currentFile.files.where((e) => e.id == id).isNotEmpty) {
  //       await API.deleteFile(id);
  //       state = AsyncData(
  //           currentFile.copyWith(files: currentFile.files.where((e) => e.id != id).toList()));
  //     }
  //   } catch (e, stack) {
  //     print(stack);
  //     state = AsyncError(e, stack);
  //   }
  // }
// }
}
