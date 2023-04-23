import 'dart:convert';

class JWT {
  static Map<String, dynamic> decode(jwt) {
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

  static bool isExpired(String token) {
    final decoded = decode(token);
    final exp = decoded['exp'];
    final now = DateTime.now().millisecondsSinceEpoch / 1000;
    return now > exp;
  }
}

// DateTime unixToDate(String unixSeconds) {
//   final epoch = DateTime.fromMillisecondsSinceEpoch(0);
//   return epoch.add(Duration(seconds: int.parse(unixSeconds)));
// }
