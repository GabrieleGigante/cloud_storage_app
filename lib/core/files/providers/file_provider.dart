import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/file.dart';

final fileFromId = FutureProvider.autoDispose.family<File, String>((ref, id) async {
  // check the local storage to see if the file is present
  // request the file to the api
  return File();
});
