import 'package:json_annotation/json_annotation.dart';
part 'file.g.dart';

@JsonSerializable(explicitToJson: true)
class File {
  final String id;
  final String name;
  final String cid;
  final String type;
  final String mimeType;
  final int size;
  File({
    this.id = '',
    this.name = '',
    this.cid = '',
    this.type = '',
    this.mimeType = '',
    this.size = 0,
  });

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);

  Map<String, dynamic> toJson() => _$FileToJson(this);
}
