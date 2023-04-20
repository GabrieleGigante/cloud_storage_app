import 'dart:convert';

Map<String, dynamic> decodeJWT(jwt) {
  final parts = jwt.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }
  String body = parts[1] ?? '';
  if (body.length % 4 != 0) {
    body += '=' * (4 - body.length % 4);
  }
  final payload = base64Decode(body);
  final payloadString = String.fromCharCodes(payload);
  return json.decode(payloadString);
}

DateTime unixToDate(String unixSeconds) {
  final epoch = DateTime.fromMillisecondsSinceEpoch(0);
  return epoch.add(Duration(seconds: int.parse(unixSeconds)));
}
