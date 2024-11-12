import 'package:slost_only1/data/dolbom_req.dart';
import 'package:slost_only1/data/page_req.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/support/server_response.dart';

abstract interface class DolbomRepository {
  Future<void> postDolbom(PostDolbomReq req);

  Future<PagedData<Dolbom>> getMyDolbom(DolbomListReq listReq, {PageReq? pageReq});

  Future<List<TeacherProfile>> getPendingTeacher(int dolbomId);
}