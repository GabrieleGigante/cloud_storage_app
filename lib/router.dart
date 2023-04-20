import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/pages/file_viewer.dart';
import 'ui/pages/folder_page.dart';
import 'ui/pages/login_page.dart';

GoRouter initRouter(SharedPreferences sp) {
  String initialLocation = '/';
  final String refreshToken = sp.getString('refresh_token') ?? '';
  if (refreshToken.isNotEmpty) {
    final String driveFolder = sp.getString('drive_folder') ?? '';
    initialLocation = '/$driveFolder';
  }
  // final bool isFirstAccess = !(sp.getBool('hasDoneOnboarding') ?? false);
  // if (isFirstAccess) {
  //   initialLocation = '/first_access';
  // }
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation,
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
}
