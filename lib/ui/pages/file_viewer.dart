import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/files/providers/file_provider.dart';
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
          child: Text(id),
        ),
      ),
      error: (_, __) => const Text('Error'),
      loading: () => const LoadingIndicator(),
    );
  }
}
