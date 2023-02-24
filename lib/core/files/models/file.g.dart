// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileAdapter extends TypeAdapter<File> {
  @override
  final int typeId = 2;

  @override
  File read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return File(
      id: fields[0] as String,
      name: fields[1] as String,
      cid: fields[2] as String,
      extension: fields[3] as String,
      mimeType: fields[4] as String,
      size: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, File obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.cid)
      ..writeByte(3)
      ..write(obj.extension)
      ..writeByte(4)
      ..write(obj.mimeType)
      ..writeByte(5)
      ..write(obj.size);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

File _$FileFromJson(Map<String, dynamic> json) => File(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      cid: json['cid'] as String? ?? '',
      extension: json['extension'] as String? ?? '',
      mimeType: json['mimeType'] as String? ?? '',
      size: json['size'] as int? ?? 0,
    );

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cid': instance.cid,
      'extension': instance.extension,
      'mimeType': instance.mimeType,
      'size': instance.size,
    };
