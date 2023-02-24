import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'file.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class File {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String cid;
  @HiveField(3)
  final String extension;
  @HiveField(4)
  final String mimeType;
  @HiveField(5)
  final int size;
  File({
    this.id = '',
    this.name = '',
    this.cid = '',
    this.extension = '',
    this.mimeType = '',
    this.size = 0,
  });

  bool get isImage => mimeType.startsWith('image/');

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);

  Map<String, dynamic> toJson() => _$FileToJson(this);
}
