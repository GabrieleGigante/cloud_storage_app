// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class File {
  @JsonKey(name: 'parentFolder')
  @HiveField(0)
  final String parentFolder;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String cid;
  @HiveField(4)
  final String extension;
  @HiveField(5)
  final String mimeType;
  @HiveField(6)
  final int size;
  File({
    this.parentFolder = '',
    this.id = '',
    this.name = '',
    this.cid = '',
    this.extension = '',
    this.mimeType = '',
    this.size = 0,
  });

  bool get isImage => mimeType.startsWith('image/');
  bool get isVideo => mimeType.startsWith('video/');

  Future<bool> verifyCid(Uint8List content) async {
    final digest = sha256.convert(content);
    return digest.toString() == cid;
  }

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);

  Map<String, dynamic> toJson() => _$FileToJson(this);
}
