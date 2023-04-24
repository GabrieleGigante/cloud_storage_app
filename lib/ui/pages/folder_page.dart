import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/files/models/file.dart';
import '../../core/files/models/folder.dart';
import '../../core/files/providers/folder_provider.dart';
import '../components/drawer.dart';
import '../components/loading_indicator.dart';
import '../components/popup_menu.dart';
import '../components/preview_widget.dart';
import 'new_file_or_dir.dart';

class FolderPage extends ConsumerWidget {
  final String id;
  const FolderPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final folderValue = ref.watch(folderFromId(id));
    final notifier = ref.read(folderFromId(id).notifier);
    final parentId = folderValue.asData?.value.parentDirectory ?? '';
    return Scaffold(
      key: scaffoldKey,
      drawer: const LeadingDrawer(),
      appBar: AppBar(
          bottom: parentId.isNotEmpty
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(20),
                  child: TextButton(
                    onPressed: () {
                      context.go('/$parentId');
                    },
                    child: Row(
                      children: [
                        Icon(Icons.adaptive.arrow_back, color: Colors.white, size: 16),
                        const Text('Back', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ))
              : null,
          leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => scaffoldKey.currentState?.openDrawer()),
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
              loading: () => const SizedBox())),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(folderFromId(id)),
        child: folderValue.when(
          data: (Folder currentDir) => ListView(
            children: [
              for (Folder folder in currentDir.folders)
                ListTile(
                  leading: const SizedBox(
                    height: 50,
                    width: 50,
                    child: Icon(Icons.folder),
                  ),
                  trailing: PopupMenu(onDelete: () async => notifier.delete(folder.id)),
                  onTap: () => context.push('/${folder.id}'),
                  title: Text(folder.name),
                  subtitle: Text(folder.id.split('-').last),
                ),
              for (File file in currentDir.files)
                ListTile(
                    leading: SizedBox(height: 50, width: 50, child: PreviewWidget(file)),
                    trailing: PopupMenu(onDelete: () async => notifier.deleteFile(file.id)),
                    onTap: () => context.push('/file/${file.id}'),
                    title: Text(file.name),
                    subtitle: Builder(builder: (context) {
                      String size = '';
                      final kb = file.size / 1024;
                      final mb = kb / 1024;
                      final gb = mb / 1024;
                      if (gb > 1) {
                        size = '${gb.toStringAsFixed(2)} GB';
                      } else if (mb > 1) {
                        size = '${mb.toStringAsFixed(2)} MB';
                      } else if (kb > 1) {
                        size = '${kb.toStringAsFixed(2)} KB';
                      } else {
                        size = '${file.size} B';
                      }
                      final shortId = file.cid.substring(0, 12);
                      // size + shortid divided by central dot
                      return Text('$size · $shortId');
                    })),
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
