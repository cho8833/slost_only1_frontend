import 'package:slost_only1/data/teacher_profile_req.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/support/server_response.dart';

abstract interface class TeacherProfileRepository {
  Future<TeacherProfile> createTeacherProfile(TeacherProfileCreateReq req);
  Future<PagedData<TeacherProfile>> getNearTeacher(String? bname, int page);
}