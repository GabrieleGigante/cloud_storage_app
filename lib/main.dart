import 'package:cloud_storage/core/files/models/folder.dart';
import 'package:cloud_storage/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/cache/cache.dart';

final ProviderContainer container = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  container.read(cacheProvider).setFolder(Folder(name: 'root', id: 'root', folders: [], files: []));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
