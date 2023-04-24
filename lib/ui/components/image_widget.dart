import 'package:cloud_storage/core/files/providers/content_provider.dart';
import 'package:cloud_storage/ui/components/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageWidget extends ConsumerWidget {
  final String id;
  const ImageWidget(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentValue = ref.watch(contentProvider(id));
    return contentValue.when(
      data: (data) {
        if (data == null) {
          return const Icon(Icons.error);
        }
        return Image.memory(data);
      },
      error: (err, stack) => Container(),
      loading: () => const LoadingIndicator(),
    );
  }
}
