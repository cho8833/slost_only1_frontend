import 'package:http_interceptor/http_interceptor.dart';
import 'package:slost_only1/data/teacher_profile_req.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/repository/teacher_profile_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/server_uri.dart';

class TeacherProfileRepositoryImpl with ServerUri, HttpResponseHandler implements TeacherProfileRepository {

  final Client interceptedClient;

  TeacherProfileRepositoryImpl(this.interceptedClient);


  @override
  Future<TeacherProfile> createTeacherProfile(TeacherProfileCreateReq req) async {
    Uri uri = getUri("/teacher");

    MultipartRequest request = MultipartRequest("PUT", uri);
    request.files.add(await MultipartFile.fromPath("profileImg", req.profileImage!.path));
    request.fields.addAll({
      "name": req.name!,
      "gender": req.gender!.json,
      "profileName": req.profileName!,
      "birthday": req.birthday!.toIso8601String(),
    });

    StreamedResponse streamedResponse = await interceptedClient.send(request);
    Response response = await Response.fromStream(streamedResponse);

    return getData(response, (p)=> TeacherProfile.fromJson(p)).data;
  }
}