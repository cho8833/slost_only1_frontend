import 'package:slost_only1/data/dolbom_req.dart';
import 'package:slost_only1/data/page_req.dart';
import 'package:slost_only1/enums/dolbom_status.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/support/server_response.dart';

abstract interface class DolbomRepository {
  Future<void> postDolbom(PostDolbomReq req);

  Future<PagedData<Dolbom>> getMyDolbom(DolbomStatus status, {PageReq? pageReq});

  Future<List<TeacherProfile>> getPendingTeacher(int dolbomId);

  Future<PagedData<Dolbom>> getMatchingDolbom({String? sido, String? sigungu, PageReq? pageReq});

  Future<PagedData<Dolbom>> getAppliedDolbom({required PageReq pageReq});

  Future<PagedData<Dolbom>> getTeacherDolbom({required DolbomStatus status, required PageReq pageReq});
}