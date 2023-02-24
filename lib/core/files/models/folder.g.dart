// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Folder _$FolderFromJson(Map<String, dynamic> json) => Folder(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      parentFolderId: json['parentFolderId'] as String? ?? '',
      folders: (json['folders'] as List<dynamic>?)
              ?.map((e) => Folder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      files: (json['files'] as List<dynamic>?)
              ?.map((e) => File.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FolderToJson(Folder instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentFolderId': instance.parentFolderId,
      'folders': instance.folders.map((e) => e.toJson()).toList(),
      'files': instance.files.map((e) => e.toJson()).toList(),
    };
