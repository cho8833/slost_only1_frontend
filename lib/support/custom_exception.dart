class UnknownServerException implements Exception {
  final String message;

  UnknownServerException(this.message);

  @override
  String toString() => message;
}

class ServerResponseException implements Exception {
  final String message;

  ServerResponseException(this.message);

  @override
  String toString() => message;
}

class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  @override
  String toString() {
    return message;
  }
}

class DataNotFoundException implements Exception {
  String? message;

  DataNotFoundException({this.message});

  @override
  String toString() => message ?? "no data";
}

class JsonParsingException implements Exception {
  String? message;

  JsonParsingException({this.message});

  @override
  String toString() {
    return message ?? "error occurred parsing json";
  }
}

class ForbiddenException implements Exception {
  @override
  String toString() {
    return '권한이 없습니다';
  }
}

class BadRequestException implements Exception {
  @override
  String toString() {
    return "잘못된 요청입니다";
  }
}

class NoPhoneNumberExeption implements Exception {}

class NotUserException implements Exception {}

class TypeException implements Exception {
  String? message;

  TypeException({this.message});

  @override
  String toString() => message ?? "type error";
}

class ConnectionException implements Exception {
  @override
  String toString() {
    return "서버와의 연결이 끊어졌습니다";
  }
}
