import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../files/models/file.dart';
import '../files/models/folder.dart';

class Cache {
  late Box<Folder> _folderBox;
  late Box<File> _fileBox;
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) {
      return;
    }
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(FolderAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(FileAdapter());
    }
    _folderBox = await Hive.openBox<Folder>('folders');
    _fileBox = await Hive.openBox<File>('files');
    _isInitialized = true;
  }

  Future<Folder?> getFolder(String id) async {
    if (!_isInitialized) {
      await init();
    }
    return _folderBox.get(id);
  }

  Future<void> setFolder(Folder folder) async {
    if (!_isInitialized) {
      await init();
    }
    await _folderBox.put(folder.id, folder);
  }

  Future<void> deleteFolder(String id) async {
    if (!_isInitialized) {
      await init();
    }
    await _folderBox.delete(id);
  }

  Future<File?> getFile(String id) async {
    if (!_isInitialized) {
      await init();
    }
    return _fileBox.get(id);
  }

  Future<void> setFile(File file) async {
    if (!_isInitialized) {
      await init();
    }
    await _fileBox.put(file.id, file);
  }

  Future<void> deleteFile(String id) async {
    if (!_isInitialized) {
      await init();
    }
    await _fileBox.delete(id);
  }
}

final cacheProvider = Provider<Cache>((ref) => Cache()..init());
