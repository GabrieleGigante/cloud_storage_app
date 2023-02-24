import 'package:cloud_storage/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/cache/cache.dart';
import 'core/files/models/folder.dart';

final ProviderContainer container = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  container.read(cacheProvider).setFolder(Folder(id: 'root', name: 'root'));
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
