import 'package:image_picker/image_picker.dart';
import 'package:slost_only1/data/available_area_req.dart';
import 'package:slost_only1/data/teacher_profile_req.dart';
import 'package:slost_only1/model/available_area.dart';
import 'package:slost_only1/model/dolbom_review.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/support/server_response.dart';

abstract interface class TeacherProfileRepository {

  Future<MyTeacherProfile> editMyTeacherProfileImage(int id, XFile file);

  Future<PagedData<TeacherProfile>> getNearTeacher(AreaListReq? req, int page);

  Future<List<AvailableArea>> getAvailableArea(int teacherProfileId);

  Future<TeacherProfile> getTeacherProfile(int id);

  Future<MyTeacherProfile> getMyTeacherProfile();

  Future<MyTeacherProfile> editMyTeacherProfile(int id, TeacherProfileEditReq req);

  Future<PagedData<DolbomReview>> getTeacherReview(int teacherId, int page);
}