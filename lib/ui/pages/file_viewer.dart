import 'dart:convert';

import 'package:cloud_storage/core/api/v1.dart';
import 'package:cloud_storage/ui/components/popup_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' show AnchorElement;

import '../../core/files/providers/content_provider.dart';
import '../../core/files/providers/file_provider.dart';
import '../../core/files/providers/folder_provider.dart';
import '../components/image_widget.dart';
import '../components/loading_indicator.dart';

class FileViewer extends HookConsumerWidget {
  final String id;
  const FileViewer(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String parent = '';
    final fileValue = ref.watch(fileFromId(id));
    if ((fileValue.value?.parentFolder ?? '').isNotEmpty) {
      parent = fileValue.value!.parentFolder;
    }

    return fileValue.when(
      data: (file) => Scaffold(
        appBar: AppBar(
          title: Text(file.name),
          actions: [
            PopupMenu(onDelete: () async {
              final sp = await SharedPreferences.getInstance();
              if (parent.isEmpty) {
                parent = sp.getString('rootDir') ?? '';
              }
              await ref.read(folderFromId(parent).notifier).deleteFile(id);
              if (context.canPop()) {
                context.pop();
                return;
              }
              if (parent.isNotEmpty) {
                context.go('/$parent');
                return;
              }
            })
          ],
        ),
        body: Center(
          child: file.isImage ? ImageWidget(id) : const Text('Preview not available'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Uint8List val = await ref.read(contentProvider(id).future);
            if (!await file.verifyCid(val)) {
              //TODO: Show error
              return;
            }
            if (kIsWeb) {
              final b64 = base64Encode(val);
              AnchorElement(href: 'data:application/octet-stream;base64,$b64')
                ..setAttribute('download', file.name)
                ..click();
              return;
            }
          },
          child: const Icon(Icons.download),
        ),
      ),
      error: (_, __) => const Text('Error'),
      loading: () => const LoadingIndicator(
        backgroundColor: Colors.white,
        spinnerColor: Colors.blue,
      ),
    );
  }
}
