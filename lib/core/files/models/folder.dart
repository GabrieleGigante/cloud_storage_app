import 'package:objectbox/objectbox.dart';

import './file.dart';

@Entity()
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
}
