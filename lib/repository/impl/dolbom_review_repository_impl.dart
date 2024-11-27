import 'dart:convert';

import 'package:http/http.dart';
import 'package:slost_only1/data/dolbom_review_req.dart';
import 'package:slost_only1/model/dolbom_review.dart';
import 'package:slost_only1/repository/dolbom_review_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/server_response.dart';
import 'package:slost_only1/support/server_uri.dart';

class DolbomReviewRepositoryImpl with ServerUri, HttpResponseHandler implements DolbomReviewRepository {

  final Client interceptedClient;

  DolbomReviewRepositoryImpl(this.interceptedClient);

  @override
  Future<DolbomReview?> getReview(int dolbomId) async {
    Uri uri = getUri("/dolbom/$dolbomId/review");

    Response response = await interceptedClient.get(uri);

    try {
      return getData(response, (p) => DolbomReview.fromJson(p)).data;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<DolbomReview> addReview(DolbomReviewCreateReq req) async {
    Uri uri = getUri("/dolbom-review");

    Response response = await interceptedClient.put(uri, body: jsonEncode(req.toJson()));

    return getData(response, (p) => DolbomReview.fromJson(p)).data;
  }

  @override
  Future<PagedData<DolbomReview>> getMyReview(int page) async {
    Uri uri = getUri("/teacher/me/review", queryParameters: {
      "page": page.toString()
    });

    Response response = await interceptedClient.get(uri);

    return getPagedData(response, (p)=> DolbomReview.fromJson(p)).data;
  }

  @override
  Future<void> reportReview(ReportDolbomReviewReq req) async {
    Uri uri = getUri("/dolbom-review/report");

    Response response = await interceptedClient.post(uri, body: jsonEncode(req.toJson()));

    checkResponse(response);
  }
}