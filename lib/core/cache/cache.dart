import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../files/models/file.dart';
import '../files/models/folder.dart';

Future<void> initCache() async {
  await Cache().init();
}

class Cache {
  late Box<Folder> _folderBox;
  late Box<File> _fileBox;
  late Box<Uint8List> _contentBox;
  static final Cache _instance = Cache._();

  Cache._();

  factory Cache() {
    return _instance;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(FolderAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(FileAdapter());
    }
    _folderBox = await Hive.openBox<Folder>('folders');
    _fileBox = await Hive.openBox<File>('files');
    _contentBox = await Hive.openBox<Uint8List>('content');
  }

  Future<Folder?> getFolder(String id) async {
    return _folderBox.get(id);
  }

  Future<void> setFolder(Folder folder) async {
    await _folderBox.put(folder.id, folder);
  }

  Future<void> deleteFolder(String id) async {
    await _folderBox.delete(id);
  }

  Future<File?> getFile(String id) async {
    return _fileBox.get(id);
  }

  Future<void> setFile(File file) async {
    await _fileBox.put(file.id, file);
  }

  Future<void> deleteFile(String id) async {
    await _fileBox.delete(id);
  }

  Future<Uint8List?> getContent(String id) async {
    return _contentBox.get(id);
  }

  Future<void> setContent(String id, Uint8List content) async {
    await _contentBox.put(id, content);
  }

  Future<void> deleteContent(String id) async {
    await _contentBox.delete(id);
  }
}

final cacheProvider = Provider<Cache>((ref) => Cache()..init());
