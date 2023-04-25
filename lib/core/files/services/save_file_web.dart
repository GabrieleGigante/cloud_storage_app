import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import '../models/file.dart';

Future<void> saveFile(File file, Uint8List content) async {
  final b64 = base64Encode(content);
  AnchorElement(href: 'data:application/octet-stream;base64,$b64')
    ..setAttribute('download', file.name)
    ..click();
}
