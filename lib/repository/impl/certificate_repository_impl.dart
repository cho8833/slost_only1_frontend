import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:slost_only1/data/certificate_req.dart';
import 'package:slost_only1/model/certificate.dart';
import 'package:slost_only1/repository/certificate_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/server_uri.dart';

class CertificateRepositoryImpl with ServerUri, HttpResponseHandler implements CertificateRepository {
  final Client interceptedClient;

  CertificateRepositoryImpl(this.interceptedClient);

  @override
  Future<List<Certificate>> getMyCertificate() async {
    Uri uri = getUri("/certificate/me");

    Response response = await interceptedClient.get(uri);

    return getListData(response, (p) => Certificate.fromJson(p)).data;

  }

  @override
  Future<void> createCertificate(CreateCertificateReq req) async {
    Uri uri = getUri("/certificate");

    Response response = await interceptedClient.put(uri, body: jsonEncode(req.toJson()));

    checkResponse(response);
  }
}