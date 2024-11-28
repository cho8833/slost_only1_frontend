import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slost_only1/data/certificate_req.dart';
import 'package:slost_only1/model/certificate.dart';
import 'package:slost_only1/repository/certificate_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/server_uri.dart';

class CertificateRepositoryImpl
    with ServerUri, HttpResponseHandler
    implements CertificateRepository {
  final Client interceptedClient;

  CertificateRepositoryImpl(this.interceptedClient);

  @override
  Future<List<Certificate>> getMyCertificate() async {
    Uri uri = getUri("/certificate/me");

    Response response = await interceptedClient.get(uri);

    return getListData(response, (p) => Certificate.fromJson(p)).data;
  }

  @override
  Future<Certificate> createCertificate(CreateCertificateReq req) async {
    Uri uri = getUri("/certificate");

    late Response response;
    MultipartRequest request = MultipartRequest("PUT", uri);
    request.fields["title"] = req.title;

    if (req.file != null) {
      request.files.add(await MultipartFile.fromPath("pdf", req.file!.path));
    }

    StreamedResponse streamedResponse = await interceptedClient.send(request);
    response = await Response.fromStream(streamedResponse);

    return getData(response, (p) => Certificate.fromJson(p)).data;
  }

  @override
  Future<Certificate> editCertificate(int id, CreateCertificateReq req) async {
    Uri uri = getUri("/certificate/$id");

    late Response response;
    MultipartRequest request = MultipartRequest("POST", uri);
    request.fields["title"] = req.title;

    if (req.file != null) {
      request.files.add(await MultipartFile.fromPath("pdf", req.file!.path));
    }

    StreamedResponse streamedResponse = await interceptedClient.send(request);
    response = await Response.fromStream(streamedResponse);

    return getData(response, (p) => Certificate.fromJson(p)).data;
  }
}
