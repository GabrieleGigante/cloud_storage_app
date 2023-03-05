import 'package:cloud_storage/core/files/interfaces/crud_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../cache/cache.dart';

class ContentRepository implements CrudRepository {
  final Ref _ref;
  final Cache cache;

  ContentRepository(this._ref) : cache = _ref.read(cacheProvider);

  @override
  Future<Uint8List?> get(String id) async {
    final res = await cache.getContent(id);
    if (res != null) {
      return res;
    }
    // do api call
    return null;
  }

  @override
  Future store(element) {
    // TODO: implement store
    throw UnimplementedError();
  }

  @override
  Future delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
