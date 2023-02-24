import 'package:cloud_storage/core/files/models/folder.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          Text('Current directory: ${currentDir.id}'),
        ],
      ),
    );
  }
}
