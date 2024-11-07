import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:slost_only1/data/kid_req.dart';
import 'package:slost_only1/model/kid.dart';
import 'package:slost_only1/repository/kid_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/server_uri.dart';

class KidRepositoryImpl with ServerUri, HttpResponseHandler implements KidRepository{

  KidRepositoryImpl(this.interceptedClient);

  final Client interceptedClient;

  @override
  Future<Kid> addKid(KidCreateReq req) async {
    Uri uri = getUri("/kid");

    Response response = await interceptedClient.put(uri, body: jsonEncode(req.toJson()));

    return getData(response, (p0) => Kid.fromJson(p0)).data;
  }

  @override
  Future<List<Kid>> getMyKidList() async {
    Uri uri = getUri("/kid");

    Response response = await interceptedClient.get(uri);

    return getListData(response, (p0) => Kid.fromJson(p0)).data;
  }

  @override
  Future<void> deleteKid(int id) async {
    Uri uri = getUri("/kid", queryParameters: {"id": id.toString()});

    Response response = await interceptedClient.delete(uri);

    checkResponse(response);
  }

  @override
  Future<Kid> editKid(KidEditReq req) async {
    Uri uri = getUri('/kid');

    Response response = await interceptedClient.post(uri, body: jsonEncode(req.toJson()));

    return getData(response, (p0) => Kid.fromJson(p0)).data;
  }

}