mixin ServerUri {
  static const String _scheme = "http";
  static const String _host = "localhost";
  static const int _port = 8081;

  // static const String _scheme = "https";
  // static const String _host = "api.slostonly1.com";



  Uri getUri(String path, {Map<String, dynamic>? queryParameters}) {
    return Uri(
        scheme: _scheme,
        host: _host,
        port: _port,
        path: path,
        queryParameters: queryParameters);
  }
}
