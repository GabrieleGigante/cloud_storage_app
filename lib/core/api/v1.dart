import 'dart:io' show HttpStatus;
import '../files/models/file.dart';
import './http_response.dart';

class APIV1 {
  /// Login with username and password.
  static Future<HTTPResponse> login(String email, String pw, bool keepLogin) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'error' || pw == 'error') {
      return HTTPResponse<String>(HttpStatus.badRequest, 'Wrong email or pw', const {});
    }
    final res = HTTPResponse<Map<String, String>>(HttpStatus.ok, {'token': 'tokenValue'}, const {});
    // set token to shared preferences
    return res;
  }

  /// Get file from id.
  static Future<HTTPResponse> getFile(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    if (id == 'error') {
      return HTTPResponse<String>(HttpStatus.badRequest, 'Wrong id', const {});
    }
    final res = HTTPResponse<File>(HttpStatus.ok, File(), const {});
    // set token to shared preferences
    return res;
  }
}
