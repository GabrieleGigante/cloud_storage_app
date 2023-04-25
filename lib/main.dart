import 'package:cloud_storage/core/api/v1.dart';
import 'package:cloud_storage/core/files/models/folder.dart';
import 'package:cloud_storage/core/files/providers/cwd_provider.dart';
import 'package:cloud_storage/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'core/cache/cache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await initCache();
  API.baseUrl = 'http://93.144.14.182';
  final SharedPreferences sp = await SharedPreferences.getInstance();
  final GoRouter router = initRouter(sp);
  runApp(MyApp(router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp(this.router, {super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Cloud Storage',
        routerConfig: router,
      ),
    );
  }
}
