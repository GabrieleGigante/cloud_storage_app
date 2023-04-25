import 'dart:io' as io;
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

import '../models/file.dart';

Future<void> saveFile(File file, Uint8List content) async {
  final dir = await getApplicationDocumentsDirectory();
  final fileToSave = io.File('${dir.path}/${file.name}');
  await fileToSave.writeAsBytes(content);
}
