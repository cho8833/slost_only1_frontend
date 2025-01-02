import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:slost_only1/data/dolbom_req.dart';
import 'package:slost_only1/data/page_req.dart';
import 'package:slost_only1/enums/dolbom_status.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/repository/dolbom_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/server_response.dart';
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

  @override
  Future<PagedData<Dolbom>> getMyDolbom(DolbomStatus status, {PageReq? pageReq}) async {
    Uri uri = getUri("/dolbom/me", queryParameters: {
      "page": pageReq?.pageNumber.toString(),
      "size": pageReq?.pageSize.toString(),
      "status": status.toJson()
    });

    Response response = await interceptedClient.get(uri);

    return getPagedData(response, (p) => Dolbom.fromJson(p)).data;
  }

  @override
  Future<List<TeacherProfile>> getPendingTeacher(int dolbomId) async {
    Uri uri = getUri("/dolbom/pending-teacher", queryParameters: {
      "dolbomId": dolbomId.toString()
    });

    Response response = await interceptedClient.get(uri);

    return getListData(response, (p0) => TeacherProfile.fromJson(p0)).data;
  }

  @override
  Future<PagedData<Dolbom>> getMatchingDolbom({String? sido, String? sigungu, PageReq? pageReq}) async {
    Uri uri = getUri("/dolbom/matching", queryParameters: {
      "sido": sido,
      "sigungu": sigungu,
      "page": pageReq?.pageNumber.toString(),
      "size": pageReq?.pageSize.toString()
    });
    Response response = await interceptedClient.get(uri);

    return getPagedData(response, (p0) => Dolbom.fromJson(p0)).data;
  }

  @override
  Future<PagedData<Dolbom>> getAppliedDolbom({required PageReq pageReq}) async {
    Uri uri = getUri("/dolbom/teacher/applied", queryParameters: {
      "page": pageReq.pageNumber.toString(),
      "size": pageReq.pageSize.toString()
    });

    Response response = await interceptedClient.get(uri);

    return getPagedData(response, (p0) => Dolbom.fromJson(p0)).data;
  }

  @override
  Future<PagedData<Dolbom>> getTeacherDolbom({required DolbomStatus status, required PageReq pageReq}) async {
    Uri uri = getUri("/dolbom/teacher/me", queryParameters: {
      "page": pageReq.pageNumber.toString(),
      "size": pageReq.pageSize.toString(),
      "status": status.json
    });

    Response response = await interceptedClient.get(uri);

    return getPagedData(response, (p0) => Dolbom.fromJson(p0)).data;
  }

  @override
  Future<void> applyDolbom(int dolbomId) async {
    Uri uri = getUri("/dolbom/apply", queryParameters: {
      "dolbomId": dolbomId.toString()
    });

    Response response = await interceptedClient.post(uri);

    checkResponse(response);
  }

  @override
  Future<void> matchDolbom(int dolbomId, int teacherProfileId) async {
    Uri uri = getUri("/dolbom/$dolbomId/match", queryParameters: {
      "teacherProfileId": teacherProfileId.toString()
    });

    Response response = await interceptedClient.post(uri);

    checkResponse(response);
  }
}