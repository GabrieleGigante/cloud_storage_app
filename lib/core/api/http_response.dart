class HTTPResponse<T> {
  final int statusCode;
  final String error;
  final T body;
  final Map<String, String> headers;

  bool get isSuccessful => statusCode >= 200 && statusCode < 300;
  bool get isRedirect => statusCode >= 300 && statusCode < 400;
  bool get isError => statusCode >= 400;
  String get requestID => headers['x-request-id'] ?? '';
  String get contentType => headers['content-type'] ?? '';
  // String get error => body.toString();

  HTTPResponse(this.statusCode, this.body, this.headers, {this.error = ''});
}
