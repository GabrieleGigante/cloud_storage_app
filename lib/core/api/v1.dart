import 'dart:convert';
import 'package:cloud_storage/core/files/services/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../files/models/folder.dart';
import 'types.dart';
import 'package:http/http.dart' as http;

class APIV1 {
  static String baseUrl = '';
  static String token = '';
  static Duration timeout = const Duration(seconds: 10);

  /// Login with username and password.
  /// returns the decoded JWT token in a Map.
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await http
        .post(
          Uri.parse('$baseUrl/auth/login'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'email': email, 'password': password}),
        )
        .timeout(timeout);
    if (res.statusCode >= 400) {
      throw APIException.fromResponse(res);
    }
    final json = jsonDecode(res.body);
    final sp = await SharedPreferences.getInstance();
    sp.setString('refresh_token', json['refresh_token']);
    token = json['access_token'];
    return decodeJWT(token);
  }

  /// Get folder from id.
  static Future<Folder> getFolder(String id, {bool populate = true}) async {
    final http.Response res = await http.get(
      Uri.parse('$baseUrl/dir/$id?populate=$populate'),
      headers: {'Authorization': 'Bearer $token'},
    ).timeout(timeout);
    if (res.statusCode >= 400) {
      throw APIException.fromResponse(res);
    }
    final json = jsonDecode(res.body);
    return Folder.fromJson(json);
  }

  /// Create folder
  static Future<void> setFolder(Folder f) async {
    final dto = FolderDTO.fromFolder(f);
    // final body = jsonEncode(dto);
    final res = await http.post(Uri.parse('$baseUrl/dir/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: dto);
    if (res.statusCode >= 400) {
      throw APIException.fromResponse(res);
    }
  }

  /// Delete folder
  static Future<void> deleteFolder(String id) async {
    final res = await http.post(
      Uri.parse('$baseUrl/dir/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode >= 400) {
      throw APIException.fromResponse(res);
    }
  }

  // static Future<void> renameDir(String id, String newName) async {
  //   await setFolder(Folder(id: id, name: newName, files: [], folders: []));
  // }
}
