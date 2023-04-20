import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_html/html.dart' show AnchorElement;

import '../../core/files/providers/content_provider.dart';
import '../../core/files/providers/file_provider.dart';
import '../components/image_widget.dart';
import '../components/loading_indicator.dart';

class FileViewer extends ConsumerWidget {
  final String id;
  const FileViewer(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileValue = ref.watch(fileFromId(id));

    return fileValue.when(
      data: (file) => Scaffold(
        appBar: AppBar(
          title: Text(file.name),
        ),
        body: Center(
          child: file.isImage ? ImageWidget(id) : const Text('Preview not available'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Uint8List? val = ref.read(contentFromId(id)).value;
            if (kIsWeb) {
              val ??= await ref.read(contentRepositoryProvider).get(id);
              final b64 = base64Encode(val as List<int>);
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
      loading: () => const LoadingIndicator(),
    );
  }
}
