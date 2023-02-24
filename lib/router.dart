import 'package:cloud_storage/ui/pages/folder.dart';
import 'package:cloud_storage/ui/pages/login.dart';
import 'package:dog/dog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage<void>(
        child: LoginPage(),
      ),
    ),
    GoRoute(
      path: '/:folderId',
      pageBuilder: (context, state) => MaterialPage<void>(
        child: FolderPage(id: state.params['folderId'] ?? ''),
      ),
    ),
  ],
);
