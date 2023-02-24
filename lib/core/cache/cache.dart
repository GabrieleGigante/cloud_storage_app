import 'dart:convert';
import 'dart:io' as io;

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

import '../files/models/file.dart';
import '../files/models/folder.dart';

class Cache {
  io.Directory _folderDir = io.Directory('');
  io.Directory _fileDir = io.Directory('');
  bool _isInitialized = false;

  Future<void> init() async {
    final temp = await getApplicationDocumentsDirectory();
    _folderDir = io.Directory('${temp.path}/folders');
    _fileDir = io.Directory('${temp.path}/files');
    _isInitialized = true;
  }

  Future<Folder?> getFolder(String id) async {
    if (!_isInitialized) {
      await init();
    }
    final folderJson = io.File('${_folderDir.path}/$id');
    if (await folderJson.exists()) {
      return Folder.fromJson(jsonDecode(await folderJson.readAsString()));
    }
    return null;
  }

  Future<void> setFolder(Folder folder) async {
    if (!_isInitialized) {
      await init();
    }
    final folderJson = io.File('${_folderDir.path}/${folder.id}');
    if (!await folderJson.exists()) {
      await folderJson.create(recursive: true);
    }
    await folderJson.writeAsString(jsonEncode(folder.toJson()));
  }

  Future<void> deleteFolder(String id) async {
    if (!_isInitialized) {
      await init();
    }
    final folderJson = io.File('${_folderDir.path}/$id');
    if (await folderJson.exists()) {
      await folderJson.delete();
    }
  }

  Future<File?> getFile(String id) async {
    if (!_isInitialized) {
      await init();
    }
    final fileJson = io.File('${_fileDir.path}/$id');
    if (await fileJson.exists()) {
      return File.fromJson(jsonDecode(await fileJson.readAsString()));
    }
    return null;
  }

  Future<void> setFile(File file) async {
    if (!_isInitialized) {
      await init();
    }
    final fileJson = io.File('${_fileDir.path}/${file.id}');
    if (!await fileJson.exists()) {
      await fileJson.create(recursive: true);
    }
    await fileJson.writeAsString(jsonEncode(file.toJson()));
  }

  Future<void> deleteFile(String id) async {
    if (!_isInitialized) {
      await init();
    }
    final fileJson = io.File('${_fileDir.path}/$id');
    if (await fileJson.exists()) {
      await fileJson.delete();
    }
  }
}

final cacheProvider = Provider<Cache>((ref) => Cache()..init());
