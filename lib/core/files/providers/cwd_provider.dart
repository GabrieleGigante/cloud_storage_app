import 'package:cloud_storage/core/files/models/folder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cwdProvider = Provider((ref) => Folder(name: 'Drive', id: 'drive:', folders: [], files: []));
