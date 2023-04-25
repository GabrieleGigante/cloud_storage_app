import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_storage/core/api/types.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http
    show Client, Request, MultipartRequest, BaseRequest, Response, post, MultipartFile;
import 'package:shared_preferences/shared_preferences.dart';

import '../files/services/token.dart';

class HTTPClient {
  HTTPClient._();

  static final HTTPClient _instance = HTTPClient._();
  final http.Client client = http.Client();

  factory HTTPClient() {
    return _instance;
  }
  Future<http.Response> request(String method, String url,
      {Map<String, String>? headers,
      dynamic body,
      Duration timeout = const Duration(seconds: 20)}) async {
    final request = http.Request(method, Uri.parse(url));
    request.followRedirects = true;
    request.headers.addAll(headers ?? {});
    request.body = '$body';
    await _checkAuthentication(request);
    final response = await client.send(request).timeout(timeout);
    final httpRes = await http.Response.fromStream(response);
    print('RESPONSE FROM STREAM');
    if (httpRes.body.length < 1000) print(httpRes.body);
    return httpRes;
  }

  Future<void> _checkAuthentication(http.BaseRequest req) async {
    final accessToken = req.headers['Authorization'] ?? '';
    if (accessToken.isEmpty) {
      return;
    }
    final token = accessToken.split(' ').last;
    if (JWT.isExpired(token)) {
      final sp = await SharedPreferences.getInstance();
      final refreshToken = sp.getString('refresh_token') ?? '';
      if (refreshToken.isEmpty) {
        throw Exception('No refresh token found');
      }
      final baseUrl = req.url.origin;
      log(baseUrl);
      final res = await http.post(Uri.parse('$baseUrl/auth/refresh'), body: {
        'access_token': token,
        'refresh_token': refreshToken,
      });
      if (res.statusCode >= 400) {
        throw APIException.fromResponse(res);
      }
      final json = jsonDecode(res.body);
      sp.setString('refresh_token', json['refresh_token']);
      sp.setString('token', json['access_token']);
      req.headers['Authorization'] = 'Bearer ${json['access_token']}';
    }
  }

  Future<http.Response> get(String url, {Map<String, String>? headers}) =>
      request('GET', url, headers: headers);

  Future<http.Response> post(String url, {Map<String, String>? headers, dynamic body}) =>
      request('POST', url, headers: headers, body: body);

  Future<http.Response> put(String url, {Map<String, String>? headers, dynamic body}) =>
      request('PUT', url, headers: headers, body: body);

  Future<http.Response> delete(String url, {Map<String, String>? headers, dynamic body}) =>
      request('DELETE', url, headers: headers, body: body);

  Future<http.Response> patch(String url, {Map<String, String>? headers, dynamic body}) =>
      request('PATCH', url, headers: headers, body: body);

  Future<http.Response> head(String url, {Map<String, String>? headers, dynamic body}) =>
      request('HEAD', url, headers: headers, body: body);

  Future<http.Response> multipart(String method, String url, PlatformFile file,
      {Map<String, String>? headers}) async {
    final request = http.MultipartRequest(method, Uri.parse(url));
    await _checkAuthentication(request);
    for (final key in headers?.keys ?? <String>[]) {
      request.headers[key.toLowerCase()] = headers?[key] ?? '';
    }
    final ct = request.headers['content-type'] ?? 'application/octet-stream';
    if (kIsWeb) {
      final bytes = file.bytes!;
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        bytes,
        contentType: MediaType.parse(ct),
        filename: file.name,
      ));
    } else {
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file.path!,
        contentType: MediaType.parse(ct),
        filename: file.name,
      ));
    }
    final response = await client.send(request);
    return http.Response.fromStream(response);
  }
}
