import 'package:objectbox/objectbox.dart';

@Entity()
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
}
