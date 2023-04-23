// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FolderAdapter extends TypeAdapter<Folder> {
  @override
  final int typeId = 1;

  @override
  Folder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Folder(
      id: fields[0] as String,
      name: fields[1] as String,
      parentDirectory: fields[2] as String,
      folders: (fields[3] as List).cast<Folder>(),
      files: (fields[4] as List).cast<File>(),
    );
  }

  @override
  void write(BinaryWriter writer, Folder obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.parentDirectory)
      ..writeByte(3)
      ..write(obj.folders)
      ..writeByte(4)
      ..write(obj.files);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Folder _$FolderFromJson(Map<String, dynamic> json) => Folder(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      parentDirectory: json['parentDirectory'] as String? ?? '',
      folders: (json['folders'] as List<dynamic>?)
              ?.map((e) => Folder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      files: (json['files'] as List<dynamic>?)
              ?.map((e) => File.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FolderToJson(Folder instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentDirectory': instance.parentDirectory,
      'folders': instance.folders.map((e) => e.toJson()).toList(),
      'files': instance.files.map((e) => e.toJson()).toList(),
    };

FolderDTO _$FolderDTOFromJson(Map<String, dynamic> json) => FolderDTO(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      parentDirectory: json['parentDirectory'] as String? ?? '',
      folders: (json['folders'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      files:
          (json['files'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$FolderDTOToJson(FolderDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentDirectory': instance.parentDirectory,
      'folders': instance.folders,
      'files': instance.files,
    };
