import 'dart:convert';
import 'dart:io' show HttpStatus;
import 'package:cloud_storage/core/api/http_client.dart';
import 'package:dartz/dartz.dart';

import '../files/models/file.dart';
import '../files/models/folder.dart';
import 'types.dart';
import 'package:http/http.dart' as http;

class APIV1 {
  static String baseUrl = '';
  static String token = '';
  static Duration timeout = const Duration(seconds: 10);

  /// Login with username and password.
  // static Future<HTTPResponse> login(String email, String pw, bool keepLogin) async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   if (email == 'error' || pw == 'error') {
  //     return HTTPResponse(
  //         HttpStatus.badRequest, {'code': '001', 'message': 'Invalid email or pw'}, const {});
  //   }
  //   final res = HTTPResponse(HttpStatus.ok, {'token': 'tokenValue'}, const {});
  //   // set token to shared preferences
  //   return res;
  // }

  /// Get file from id.
  // static Future<HTTPResponse> getFile(String id) async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   if (id == 'error') {
  //     return HTTPResponse(
  //         HttpStatus.badRequest, {'code': '001', 'message': 'Invalid email or pw'}, const {});
  //   }
  //   final res = HTTPResponse(HttpStatus.ok, {}, const {});
  //   // set token to shared preferences
  //   return res;
  // }

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
}
