import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/folder.dart';

final folderFromId = FutureProvider.autoDispose.family<Folder, String>((ref, id) async {
  // check the local storage to see if the file is present
  // request the file to the api
  return Folder(name: id);
});
