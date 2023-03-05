import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/file.dart';
import '../repositories/file_repository.dart';

final fileRepositoryProvider = Provider<FileRepository>((ref) => FileRepository(ref));
final fileFromId = FutureProvider.family<File, String>((ref, id) async {
  final repo = ref.read(fileRepositoryProvider);
  return repo.get(id);
});
