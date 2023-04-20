import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/files/models/file.dart';
import '../../core/files/models/folder.dart';
import '../../core/files/providers/folder_provider.dart';
import '../components/loading_indicator.dart';
import '../components/popup_menu.dart';
import '../components/preview_widget.dart';
import 'new_file_or_dir.dart';

class FolderPage extends ConsumerWidget {
  final String id;
  const FolderPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folderValue = ref.watch(folderFromId(id));
    return Scaffold(
      appBar: AppBar(
          title: folderValue.when(
              data: (folder) => Text(folder.name),
              error: (_, __) => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () => ref.refresh(folderFromId(id)),
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ))
                    ],
                  ),
              loading: () => const Text('Loading...'))),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(folderFromId(id)),
        child: folderValue.when(
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
                  leading: SizedBox(height: 50, width: 50, child: PreviewWidget(file)),
                  trailing: PopupMenu(
                    onDelete: () async => ref.read(folderFromId(id).notifier).store(
                          currentDir.copyWith(
                            files:
                                currentDir.files.where((element) => element.id != file.id).toList(),
                          ),
                        ),
                  ),
                  onTap: () => context.push('/file/${file.id}'),
                  title: Text(file.name),
                  subtitle: Text(file.id),
                ),
            ],
          ),
          error: (err, stack) {
            return Center(
              child: Text(err.toString()),
            );
          },
          loading: () => const LoadingIndicator(),
        ),
      ),
      floatingActionButton: !folderValue.isLoading && !folderValue.hasError
          ? FloatingActionButton(
              onPressed: () async {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (_) => NewFileOrDirDialog(folderValue.asData!.value),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
