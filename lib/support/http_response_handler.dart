import 'dart:convert';

import 'package:http/http.dart';
import 'package:slost_only1/support/server_response.dart';
import 'package:slost_only1/support/custom_exception.dart';

mixin HttpResponseHandler {
  Map<String, dynamic> checkResponse(Response response) {
    if (response.statusCode == 403) {
      throw ForbiddenException();
    }
    late Map<String, dynamic> json;
    try {
      json = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw JsonParsingException();
    }
    if (response.statusCode == 200) {
      switch (json['status'] as int) {
        case 200:
          return json;
        case 400:
          throw ServerResponseException(json['message']);
        case 403:
          throw ForbiddenException();
        case 404:
          throw DataNotFoundException();
        default:
          throw UnknownServerException(json['message']);
      }
    }
    throw UnknownServerException("unknown server error");
  }

  ServerResponse<T> getData<T>(
      Response response, T Function(Map<String, dynamic>) fromJson) {
    Map<String, dynamic> data = checkResponse(response);
    return ServerResponse.fromResponse(data, fromJson);
  }

  ServerResponse<List<T>> getListData<T>(
      Response response, T Function(Map<String, dynamic> fromJson) fromJson) {
        Map<String ,dynamic> data = checkResponse(response);
        return ServerListResponse.fromResponse(data, fromJson);
  }

  ServerResponse<PagedData<T>> getPagedData<T>(
      Response response, T Function(Map<String, dynamic>) fromJson) {
    Map<String, dynamic> data = checkResponse(response);
    return ServerPagedResponse.fromResponse(data, fromJson);
  }
}
