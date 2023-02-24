import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PopupMenu extends ConsumerWidget {
  final VoidCallback? onDelete;
  const PopupMenu({Key? key, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) => [
        PopupMenuItem(
          onTap: onDelete,
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
