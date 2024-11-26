import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slost_only1/data/available_area_req.dart';
import 'package:slost_only1/data/teacher_profile_req.dart';
import 'package:slost_only1/model/available_area.dart';
import 'package:slost_only1/model/dolbom_review.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/repository/teacher_profile_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/server_response.dart';
import 'package:slost_only1/support/server_uri.dart';

class TeacherProfileRepositoryImpl
    with ServerUri, HttpResponseHandler
    implements TeacherProfileRepository {
  final Client interceptedClient;

  TeacherProfileRepositoryImpl(this.interceptedClient);

  @override
  Future<PagedData<TeacherProfile>> getNearTeacher(
      AreaListReq? req, int page) async {
    Uri uri = getUri("/teacher/near", queryParameters: {
      "sigungu": req?.sigungu,
      "sido": req?.sido,
      "page": page.toString()
    });
    Response response = await interceptedClient.get(uri);

    return getPagedData(response, (p) => TeacherProfile.fromJson(p)).data;
  }

  @override
  Future<MyTeacherProfile> editMyTeacherProfileImage(int id, XFile file) async {
    Uri uri = getUri("/teacher/$id/profile-image");

    MultipartRequest request = MultipartRequest("POST", uri);
    request.files.add(await MultipartFile.fromPath("profileImg", file.path));

    StreamedResponse streamedResponse = await interceptedClient.send(request);
    Response response = await Response.fromStream(streamedResponse);

    return getData(response, (p) => MyTeacherProfile.fromJson(p)).data;
  }

  @override
  Future<List<AvailableArea>> getAvailableArea(int teacherProfileId) async {
    Uri uri = getUri("/teacher/available-area",
        queryParameters: {"teacherProfileId": teacherProfileId.toString()});

    Response response = await interceptedClient.get(uri);

    return getListData(response, (p) => AvailableArea.fromJson(p)).data;
  }

  jsonToFormData(MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

  @override
  Future<TeacherProfile> getTeacherProfile(int id) async {
    Uri uri = getUri("/teacher/$id");

    Response response = await interceptedClient.get(uri);

    return getData(response, (p) => TeacherProfile.fromJson(p)).data;
  }

  @override
  Future<MyTeacherProfile> getMyTeacherProfile() async {
    Uri uri = getUri("/teacher/me");

    Response response = await interceptedClient.get(uri);

    return getData(response, (p) => MyTeacherProfile.fromJson(p)).data;
  }

  @override
  Future<MyTeacherProfile> editMyTeacherProfile(
      int id, TeacherProfileEditReq req) async {
    Uri uri = getUri("/teacher/$id");
    Response response =
        await interceptedClient.patch(uri, body: jsonEncode(req.toJson()));

    return getData(response, (p) => MyTeacherProfile.fromJson(p)).data;
  }

  @override
   Future<PagedData<DolbomReview>> getTeacherReview(int teacherId, int page) async {
    Uri uri = getUri("/teacher/$teacherId/review", queryParameters: {
      "page": page.toString()
    });

    Response response = await interceptedClient.get(uri);

    return getPagedData(response, (p) => DolbomReview.fromJson(p)).data;
   }
}
