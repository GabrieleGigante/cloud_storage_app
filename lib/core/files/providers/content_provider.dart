import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repositories/content_repository.dart';

final contentRepositoryProvider = Provider<ContentRepository>((ref) => ContentRepository(ref));
final contentFromId = FutureProvider.family<Uint8List?, String>((ref, id) async {
  final repo = ref.read(contentRepositoryProvider);
  return repo.get(id);
});
