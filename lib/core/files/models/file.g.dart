// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

File _$FileFromJson(Map<String, dynamic> json) => File(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      cid: json['cid'] as String? ?? '',
      type: json['type'] as String? ?? '',
      mimeType: json['mimeType'] as String? ?? '',
      size: json['size'] as int? ?? 0,
    );

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cid': instance.cid,
      'type': instance.type,
      'mimeType': instance.mimeType,
      'size': instance.size,
    };
