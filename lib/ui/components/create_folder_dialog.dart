import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateFolderDialog extends ConsumerWidget {
  const CreateFolderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    return AlertDialog(
      title: const Text('Create new folder'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Folder name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(controller.text.trim()),
          child: const Text('Create'),
        ),
      ],
    );
  }
}
