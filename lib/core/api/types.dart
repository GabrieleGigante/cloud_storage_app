import 'dart:convert';

import 'package:http/http.dart';

class HTTPResponse {
  final int statusCode;
  final String error;
  final Map<String, dynamic> body;
  final Map<String, String> headers;

  bool get isSuccessful => statusCode >= 200 && statusCode < 300;
  bool get isRedirect => statusCode >= 300 && statusCode < 400;
  bool get isError => statusCode >= 400;
  String get requestID => headers['x-request-id'] ?? '';
  String get contentType => headers['content-type'] ?? '';
  // String get error => body.toString();

  HTTPResponse(this.statusCode, this.body, this.headers, {this.error = ''});
}

class APIException {
  final String code;
  final String requestID;
  final String message;

  APIException(this.code, this.requestID, this.message);

  factory APIException.fromResponse(Response response) {
    final reqID = response.headers['x-request-id'] ?? '';
    try {
      final json = jsonDecode(response.body);
      return APIException(
          json['code'] ?? response.statusCode.toString(), reqID, json['message'] ?? response.body);
    } on FormatException {
      return APIException(response.statusCode.toString(), reqID, response.body);
    }
  }

  @override
  String toString() {
    return '[$code - $requestID] $message';
  }
}
