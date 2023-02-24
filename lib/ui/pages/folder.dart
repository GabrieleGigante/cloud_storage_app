import 'package:cloud_storage/core/files/models/file.dart';
import 'package:cloud_storage/core/files/providers/folder_provider.dart';
import 'package:cloud_storage/ui/components/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/files/models/folder.dart';
import 'new_file_or_dir.dart';

class FolderPage extends ConsumerWidget {
  final String id;
  const FolderPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folderAV = ref.watch(folderFromId(id));
    return Scaffold(
      appBar: AppBar(
        title: Text('Folder $id'),
      ),
      body: folderAV.when(
        data: (Folder currentDir) => ListView(
          children: [
            for (Folder folder in currentDir.folders)
              ListTile(
                title: Text(folder.name),
                subtitle: Text(folder.id),
              ),
            for (File file in currentDir.files)
              ListTile(
                title: Text(file.name),
                subtitle: Text(file.id),
              ),
          ],
        ),
        error: (_, __) {},
        loading: () => const LoadingIndicator(),
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
