import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:slost_only1/data/dolbom_req.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/repository/dolbom_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/server_uri.dart';

class DolbomRepositoryImpl with HttpResponseHandler, ServerUri implements DolbomRepository {
  DolbomRepositoryImpl(this.interceptedClient);

  final Client interceptedClient;


  @override
  Future<void> postDolbom(PostDolbomReq req) async {
    Uri uri = getUri("/dolbom");

    Response response = await interceptedClient.post(uri, body: jsonEncode(req.toJson()));

    checkResponse(response);
  }
}