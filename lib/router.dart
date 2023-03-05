import 'package:cloud_storage/ui/pages/folder_page.dart';
import 'package:cloud_storage/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'ui/pages/file_viewer.dart';

GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage<void>(
        child: LoginPage(),
      ),
    ),
    GoRoute(
      path: '/file/:id',
      pageBuilder: (context, state) => MaterialPage<void>(
        child: FileViewer(state.params['id'] ?? ''),
      ),
    ),
    GoRoute(
      path: '/:folderId',
      pageBuilder: (context, state) => MaterialPage<void>(
        child: FolderPage(state.params['folderId'] ?? ''),
      ),
    ),
  ],
);
