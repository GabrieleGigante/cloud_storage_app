import 'dart:convert';
import 'package:cloud_storage/core/api/http_client.dart';
import 'package:cloud_storage/core/files/models/file.dart';
import 'package:cloud_storage/core/files/services/token.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../files/models/folder.dart';
import 'types.dart';

class API {
  static String baseUrl = '';
  // static String token = '';
  static Duration timeout = const Duration(seconds: 10);
  static final http = HTTPClient();

  /// Login with username and password.
  /// returns the decoded JWT token in a Map.
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await http
        .post(
          '$baseUrl/auth/login',
          body: jsonEncode({'email': email, 'password': password}),
        )
        .timeout(timeout);
    if (res.statusCode >= 400) {
      throw APIException.fromResponse(res);
    }
    final json = jsonDecode(res.body);
    final sp = await SharedPreferences.getInstance();
    sp.setString('refresh_token', json['refresh_token']);
    final at = json['access_token'];
    sp.setString('token', at);
    return JWT.decode(at);
  }

  static Future<void> logout() async {
    final sp = await SharedPreferences.getInstance();
    await http.post('$baseUrl/auth/logout', headers: {
      'Authorization': 'Bearer ${sp.getString('token')}',
    });
    sp.remove('refresh_token');
    sp.remove('token');
  }

  /// Get folder from id.
  static Future<Folder> getFolder(String id, {bool populate = true}) async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token') ?? '';
    final res = await HTTPClient().get('$baseUrl/dir/$id?populate=$populate', headers: {
      'Authorization': 'Bearer $token',
    });
    if (res.statusCode >= 400) {
      throw APIException.fromResponse(res);
    }
    final json = jsonDecode(res.body);
    return Folder.fromJson(json);
  }

  /// Create folder
  static Future<void> setFolder(Folder f) async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token') ?? '';
    final dto = FolderDTO.fromFolder(f);
    // final body = jsonEncode(dto);
    final body = dto.toJson();
    final res = await http.post('$baseUrl/dir/',
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body));
    if (res.statusCode >= 400) {
      throw APIException.fromResponse(res);
    }
  }

  /// Delete folder
  static Future<void> deleteFolder(String id) async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token') ?? '';
    final res = await http.post(
      '$baseUrl/dir/$id',
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

  static Future<File> uploadFile(PlatformFile f, String folderId) async {
    print(f);
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token') ?? '';
    final res = await http.multipart('POST', '$baseUrl/file/', f.path ?? '', headers: {
      'cwd': folderId,
      'Authorization': 'Bearer $token',
    });
    if (res.statusCode >= 400) {
      throw APIException.fromResponse(res);
    }
    final json = jsonDecode(res.body);
    return File.fromJson(json);
  }
}
