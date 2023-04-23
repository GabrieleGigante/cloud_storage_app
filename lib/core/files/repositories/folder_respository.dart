// import 'package:cloud_storage/core/api/v1.dart';
// import 'package:dartz/dartz.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../cache/cache.dart';
// import '../interfaces/crud_repository.dart';
// import '../models/folder.dart';

// class FolderRepository implements CrudRepository<Folder> {
//   final Ref _ref;

//   FolderRepository(this._ref);

//   @override
//   Future<Folder> get(String id) async {
//     // final f = await cache.getFolder(id);
//     // if (f != null) {
//     //   return f;
//     // }
//     // return Folder(folders: [], files: []);
//     return await API.getFolder(id);
//   }

//   @override
//   Future<Folder?> store(Folder folder) async {
//     // await Cache().setFolder(folder);
//     await API.setFolder(folder);
//     return null;
//   }

//   @override
//   Future<Folder?> delete(String id) async {
//     await Cache().deleteFolder(id);
//     await API.deleteFolder(id);
//     return null;
//   }
// }
