import 'package:cloud_storage/core/cache/cache.dart';
import 'package:cloud_storage/core/files/interfaces/crud_repository.dart';
import 'package:dog/dog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/file.dart';
import '../repositories/file_repository.dart';

final fileRepositoryProvider = Provider<FileRepository>((ref) => FileRepository(ref));
final fileFromId = FutureProvider.family<File, String>((ref, id) async {
  final repo = ref.read(fileRepositoryProvider);
  return repo.get(id);
});
