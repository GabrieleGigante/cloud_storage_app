// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import './file.dart';

part 'folder.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true, createToJson: true)
class Folder {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String parentDirectory;
  @HiveField(3)
  @JsonKey(defaultValue: [])
  List<Folder> folders;
  @HiveField(4)
  @JsonKey(defaultValue: [])
  List<File> files;

  bool get canPop => parentDirectory.isNotEmpty;

  Folder({
    this.id = '',
    this.name = '',
    this.parentDirectory = '',
    required this.folders,
    required this.files,
  });

  Folder copyWith({
    String? id,
    String? name,
    String? parentDirectory,
    List<Folder>? folders,
    List<File>? files,
  }) {
    return Folder(
      id: id ?? this.id,
      name: name ?? this.name,
      parentDirectory: parentDirectory ?? this.parentDirectory,
      folders: folders ?? this.folders,
      files: files ?? this.files,
    );
  }

  factory Folder.empty() => Folder(
        folders: [],
        files: [],
      );

  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);

  Map<String, dynamic> toJson() => _$FolderToJson(this);
}

@JsonSerializable(explicitToJson: true, createToJson: true)
class FolderDTO {
  String id;
  String name;
  String parentDirectory;
  List<String> folders;
  List<String> files;
  FolderDTO({
    this.id = '',
    this.name = '',
    this.parentDirectory = '',
    this.folders = const [],
    this.files = const [],
  });

  factory FolderDTO.fromFolder(Folder f) {
    return FolderDTO(
      id: f.id,
      name: f.name,
      parentDirectory: f.parentDirectory,
      folders: f.folders.map((e) => e.id).toList(),
      files: f.files.map((e) => e.id).toList(),
    );
  }

  factory FolderDTO.fromJson(Map<String, dynamic> json) => _$FolderDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FolderDTOToJson(this);
}
