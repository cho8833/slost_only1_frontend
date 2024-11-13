import 'package:flutter/cupertino.dart';
import 'package:slost_only1/data/dolbom_req.dart';
import 'package:slost_only1/data/page_req.dart';
import 'package:slost_only1/enums/dolbom_status.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/repository/dolbom_repository.dart';
import 'package:slost_only1/support/server_response.dart';
import 'package:slost_only1/widget/dolbom/create_dolbom/create_dolbom_context.dart';
import 'package:status_builder/status_builder.dart';

class DolbomProvider {
  DolbomProvider(this.dolbomRepository);

  final DolbomRepository dolbomRepository;

  ValueNotifier<Status> getMyDolbomStatus = ValueNotifier(Status.loading);
  String getMyDolbomErrorMessage = "";
  PagedData<Dolbom>? myDolboms;

  ValueNotifier<Status> getPendingTeacherStatus = ValueNotifier(Status.loading);
  String getPendingTeacherErrorMessage = "";
  List<TeacherProfile> pendingTeachers = [];

  ValueNotifier<Status> getMatchingDolbomStatus = ValueNotifier(Status.loading);
  String getMatchingDolbomErrorMessage = "";
  PagedData<Dolbom>? matchingDolbom;

  ValueNotifier<Status> postDolbomStatus = ValueNotifier(Status.idle);

  Future<void> postDolbom(CreateDolbomContext createContext) async {
    postDolbomStatus.value = Status.loading;
    await dolbomRepository
        .postDolbom(PostDolbomReq.from(createContext))
        .then((_) {
      postDolbomStatus.value = Status.success;
    });
  }

  Future<void> getMyDolbom(DolbomStatus status) async {
    getMyDolbomStatus.value = Status.loading;
    await dolbomRepository.getMyDolbom(status).then((pagedData) {
      myDolboms = pagedData;

      getMyDolbomStatus.value = Status.success;
    }).catchError((e) {
      getMyDolbomStatus.value = Status.fail;
      getMyDolbomErrorMessage = e.toString();
    });
  }

  Future<void> getPendingTeacher(int dolbomId) async {
    getPendingTeacherStatus.value = Status.loading;
    await dolbomRepository.getPendingTeacher(dolbomId).then((data) {
      pendingTeachers = data;
      getPendingTeacherStatus.value = Status.success;
    }).catchError((e) {
      getPendingTeacherStatus.value = Status.fail;
      getPendingTeacherErrorMessage = e.toString();
    });
  }

  Future<void> getMatchingDolbom(int page,
      {String? sido, String? sigungu}) async {
    await dolbomRepository
        .getMatchingDolbom(
            sido: sido, sigungu: sigungu, pageReq: PageReq(page, 10))
        .then((data) {
      matchingDolbom = data;
    });
  }
}
