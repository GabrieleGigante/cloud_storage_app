import 'package:cloud_storage/core/api/v1.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repositories/content_repository.dart';

// final contentFromCid = StateProviderFamily<Uint8List, String>((ref, cid) => Uint8List(0));

final contentProvider =
    FutureProviderFamily<Uint8List, String>((ref, id) async => API.downloadFile(id));
