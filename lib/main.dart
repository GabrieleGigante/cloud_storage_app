import 'package:cloud_storage/core/files/models/folder.dart';
import 'package:cloud_storage/core/files/providers/cwd_provider.dart';
import 'package:cloud_storage/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

import 'core/cache/cache.dart';

final ProviderContainer container = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  final cache = container.read(cacheProvider);
  final cwd = container.read(cwdProvider);
  if (await cache.getFolder(cwd.id) == null) {
    await cache.setFolder(cwd);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        title: 'Cloud Storage',
        routerConfig: router,
      ),
    );
  }
}
