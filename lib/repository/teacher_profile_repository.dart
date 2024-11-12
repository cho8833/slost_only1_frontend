import 'package:slost_only1/data/teacher_profile_req.dart';
import 'package:slost_only1/model/teacher_profile.dart';

abstract interface class TeacherProfileRepository {
  Future<TeacherProfile> createTeacherProfile(TeacherProfileCreateReq req);
}