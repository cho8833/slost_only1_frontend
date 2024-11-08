import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:slost_only1/data/dolbom_location_req.dart';
import 'package:slost_only1/model/dolbom_location.dart';
import 'package:slost_only1/repository/dolbom_location_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/server_uri.dart';

class DolbomLocationRepositoryImpl with ServerUri, HttpResponseHandler implements DolbomLocationRepository {

  DolbomLocationRepositoryImpl(this.interceptedClient);

  final Client interceptedClient;


  @override
  Future<List<DolbomLocation>> getList() async {
    Uri uri = getUri("/dolbom-location");

    Response response = await interceptedClient.get(uri);

    return getListData(response, (p) => DolbomLocation.fromJson(p)).data;
  }

  @override
  Future<DolbomLocation> create(DolbomLocationCreateReq req) async {
    Uri uri = getUri("/dolbom-location");
    
    Response response = await interceptedClient.put(uri, body: jsonEncode(req.toJson()));

    return getData(response, (p) => DolbomLocation.fromJson(p)).data;
  }

  @override
  Future<void> delete(int id) async {
    Uri uri = getUri("/dolbom-location", queryParameters: {"id": id.toString()});
    
    Response response = await interceptedClient.delete(uri);
    
    checkResponse(response);
  }

}