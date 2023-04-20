// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:cloud_storage/core/api/types.dart';
// import 'package:http/http.dart' as http show get, post, Request, Response, ByteStream;

// typedef HTTPGet = Future<http.Response> Function(
//   Uri url, {
//   Map<String, String>? headers,
// });
// typedef HTTPPost = Future<http.Response> Function(
//   Uri url, {
//   Map<String, String>? headers,
//   Object? body,
//   Encoding? encoding,
// });

// class HTTPClient {
//   HTTPClient._();

//   static final HTTPClient _instance = HTTPClient._();

//   factory HTTPClient() {
//     return _instance;
//   }
//   Future<HTTPResponse> request(String method, String url,
//       {Map<String, String>? headers, dynamic body, int timeout = 20}) async {
//     late final HTTPGet client;
//     switch (method) {
//       case 'GET':
//         client = http.get;
//         break;
//       // case 'POST':
//       //   client = http.post;
//       //   break;
//       default:
//     }
//     bool clientClosed = false;
//     try {
//       final duration = Duration(seconds: timeout);
//       Future.delayed(duration, () {
//         if (!clientClosed) {
//           throw TimeoutException('Request timed out', duration);
//         }
//       });
//       final request = http.Request(method, Uri.parse(url));
//       request.followRedirects = true;
//       request.headers.addAll(headers ?? {});
//       request.body = body.toString();
//       final response = await client(request.url, headers: request.headers);
//       final responseString = await response.stream.bytesToString();
//       if (response.statusCode >= 400) {
//         return HTTPResponse(response.statusCode, {}, response.headers, error: responseString);
//       }
//       final Map<String, dynamic> responseBodyMap = jsonDecode(responseString);
//       return HTTPResponse(response.statusCode, responseBodyMap, response.headers);
//     } catch (e) {
//       return HTTPResponse(HttpStatus.internalServerError, {}, {}, error: e.toString());
//     } finally {
//       clientClosed = true;
//     }
//   }

//   Future<HTTPResponse> get(String url, {Map<String, String>? headers}) =>
//       request('GET', url, headers: headers);

//   Future<HTTPResponse> post(String url, {Map<String, String>? headers, dynamic body}) =>
//       request('POST', url, headers: headers, body: body);

//   Future<HTTPResponse> put(String url, {Map<String, String>? headers, dynamic body}) =>
//       request('PUT', url, headers: headers, body: body);

//   Future<HTTPResponse> delete(String url, {Map<String, String>? headers, dynamic body}) =>
//       request('DELETE', url, headers: headers, body: body);

//   Future<HTTPResponse> patch(String url, {Map<String, String>? headers, dynamic body}) =>
//       request('PATCH', url, headers: headers, body: body);

//   Future<HTTPResponse> head(String url, {Map<String, String>? headers, dynamic body}) =>
//       request('HEAD', url, headers: headers, body: body);
// }
