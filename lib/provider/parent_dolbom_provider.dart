import 'package:flutter/cupertino.dart';
import 'package:slost_only1/data/dolbom_req.dart';
import 'package:slost_only1/enums/dolbom_status.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/repository/dolbom_repository.dart';
import 'package:slost_only1/support/server_response.dart';
import 'package:slost_only1/parent_screen/create_dolbom/create_dolbom_context.dart';
import 'package:status_builder/status_builder.dart';

class ParentDolbomProvider {
  ParentDolbomProvider(this.dolbomRepository);

  final DolbomRepository dolbomRepository;

  ValueNotifier<Status> getPendingTeacherStatus = ValueNotifier(Status.loading);
  String getPendingTeacherErrorMessage = "";
  List<TeacherProfile> pendingTeachers = [];

  ValueNotifier<Status> postDolbomStatus = ValueNotifier(Status.idle);

  Future<void> postDolbom(CreateDolbomContext createContext) async {
    postDolbomStatus.value = Status.loading;
    await dolbomRepository
        .postDolbom(PostDolbomReq.from(createContext))
        .then((_) {
      postDolbomStatus.value = Status.success;
    });
  }

  Future<PagedData<Dolbom>> getMyDolbom(DolbomStatus status) async {
    return dolbomRepository.getMyDolbom(status);
  }

  Future<void> getAppliedTeacher(int dolbomId) async {
    getPendingTeacherStatus.value = Status.loading;
    await dolbomRepository.getPendingTeacher(dolbomId).then((data) {
      pendingTeachers = data;
      getPendingTeacherStatus.value = Status.success;
    }).catchError((e) {
      getPendingTeacherStatus.value = Status.fail;
      getPendingTeacherErrorMessage = e.toString();
    });
  }
}
