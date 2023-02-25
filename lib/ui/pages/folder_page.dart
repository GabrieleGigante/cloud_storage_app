import 'package:cloud_storage/core/files/models/file.dart';
import 'package:cloud_storage/core/files/providers/folder_provider.dart';
import 'package:cloud_storage/ui/components/loading_indicator.dart';
import 'package:dog/dog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/files/models/folder.dart';
import '../components/popup_menu.dart';
import 'new_file_or_dir.dart';

class FolderPage extends ConsumerWidget {
  final String id;
  const FolderPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    dog.w(id);
    final folderAV = ref.watch(folderFromId(id));
    return Scaffold(
      appBar: AppBar(
          title: folderAV.when(
              data: (folder) => Text('Folder ${folder.name}'),
              error: (_, __) => Container(),
              loading: () => const Text('Loading...'))),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(folderFromId(id)),
        child: folderAV.when(
          data: (Folder currentDir) => ListView(
            children: [
              for (Folder folder in currentDir.folders)
                ListTile(
                  leading: const Icon(Icons.folder),
                  trailing: PopupMenu(
                    onDelete: () async => ref.read(folderFromId(id).notifier).store(
                          currentDir.copyWith(
                            folders: currentDir.folders
                                .where((element) => element.id != folder.id)
                                .toList(),
                          ),
                        ),
                  ),
                  onTap: () => context.push('/${folder.id}'),
                  title: Text(folder.name),
                  subtitle: Text(folder.id),
                ),
              for (File file in currentDir.files)
                ListTile(
                  leading: Icon(file.isImage ? Icons.image : Icons.document_scanner),
                  trailing: PopupMenu(
                    onDelete: () async => ref.read(folderFromId(id).notifier).store(
                          currentDir.copyWith(
                            files:
                                currentDir.files.where((element) => element.id != file.id).toList(),
                          ),
                        ),
                  ),
                  onTap: () => dog.i('File ${file.id} tapped'),
                  title: Text(file.name),
                  subtitle: Text(file.id),
                ),
            ],
          ),
          error: (_, __) => Center(
            child: Text('Error: ${folderAV.error}'),
          ),
          loading: () => const LoadingIndicator(),
        ),
      ),
      floatingActionButton: !folderAV.isLoading && !folderAV.hasError
          ? FloatingActionButton(
              onPressed: () async {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (_) => NewFileOrDirDialog(folderAV.asData!.value),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
