import 'package:cloud_storage/core/files/models/folder.dart';
import 'package:cloud_storage/core/files/providers/folder_provider.dart';
import 'package:cloud_storage/core/files/services/extension_to_mime.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/cache/cache.dart';
import '../../core/files/models/file.dart';
import '../components/create_folder_dialog.dart';
import 'package:image/image.dart';

class NewFileOrDirDialog extends ConsumerWidget {
  final Folder currentDir;
  const NewFileOrDirDialog(this.currentDir, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Current directory: ${currentDir.name}'),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.file_upload),
                SizedBox(width: 8),
                Text('New file'),
              ],
            ),
            onTap: () async {
              final res = await FilePicker.platform.pickFiles();
              if (res != null) {
                final file = res.files.first;
                final uuid = const Uuid().v4();
                final newFile = File(
                  id: uuid,
                  name: file.name,
                  extension: file.extension ?? '',
                  mimeType: extensionToMimetype(file.extension ?? ''),
                  size: file.size,
                );
                final newFolder = currentDir.copyWith(files: [...currentDir.files, newFile]);
                ref.read(folderFromId(currentDir.id).notifier).store(newFolder);
                ref.read(cacheProvider).setFile(newFile);
                // TODO: remove when the backend is ready
                ref.read(cacheProvider).setContent(uuid, file.bytes!);
                if (newFile.isImage) {
                  final image = decodeImage(file.bytes!);
                  final resized = copyResize(image!, width: 200);
                  final preview = encodeNamedImage('${file.name}.${file.extension}', resized);
                  if (preview != null) {
                    ref.read(cacheProvider).setContent('preview_$uuid', preview);
                  }
                }
                context.pop();
              }
            },
          ),
          const Divider(),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.folder),
                SizedBox(width: 8),
                Text('New folder'),
              ],
            ),
            onTap: () async {
              String folderName = await showDialog(
                    context: context,
                    builder: (_) => const CreateFolderDialog(),
                  ) ??
                  '';
              if (folderName.isNotEmpty) {
                final uuid = const Uuid().v4();
                final newFolder = Folder(
                  parentFolderId: currentDir.id,
                  id: uuid,
                  name: folderName,
                  folders: [],
                  files: [],
                );
                final newCurrentDir =
                    currentDir.copyWith(folders: [...currentDir.folders, newFolder]);
                ref.read(cacheProvider).setFolder(newFolder);
                ref.read(folderFromId(currentDir.id).notifier).store(newCurrentDir);
              }
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
