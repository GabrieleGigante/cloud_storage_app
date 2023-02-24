import './file.dart';

import 'package:json_annotation/json_annotation.dart';
part 'folder.g.dart';

@JsonSerializable(explicitToJson: true)
class Folder {
  String id;
  String name;
  String parentFolderId;
  List<Folder> folders;
  List<File> files;

  bool get canPop => parentFolderId.isNotEmpty;

  Folder({
    this.id = '',
    this.name = '',
    this.parentFolderId = '',
    this.folders = const [],
    this.files = const [],
  });

  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);

  Map<String, dynamic> toJson() => _$FolderToJson(this);
}
