import 'package:cloud_storage/core/files/models/file.dart';
import 'package:cloud_storage/ui/components/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PreviewWidget extends StatelessWidget {
  final File file;
  const PreviewWidget(this.file, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!file.isImage) {
      return const Icon(Icons.document_scanner);
    }
    return ImageWidget(file.id);
  }
}
