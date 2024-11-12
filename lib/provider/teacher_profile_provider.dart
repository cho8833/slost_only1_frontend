import 'package:flutter/cupertino.dart';
import 'package:slost_only1/data/teacher_profile_req.dart';
import 'package:slost_only1/model/available_area.dart';
import 'package:slost_only1/model/teacher_profile.dart';
import 'package:slost_only1/repository/teacher_profile_repository.dart';
import 'package:slost_only1/support/server_response.dart';
import 'package:status_builder/status_builder.dart';

class TeacherProfileProvider {

  final TeacherProfileRepository repository;

  TeacherProfileProvider(this.repository);

  ValueNotifier<Status> createProfileStatus = ValueNotifier(Status.idle);

  ValueNotifier<Status> getTeacherStatus = ValueNotifier(Status.loading);
  PagedData<TeacherProfile>? teachers;
  String getTeacherErrorMessage  = "";

  ValueNotifier<Status> getAvailableAreaStatus = ValueNotifier(Status.loading);
  String getAvailableAreaErrorMessage = "";
  List<AvailableArea> availableAreas = [];


  Future<void> createProfile(TeacherProfileCreateReq req) async {
    createProfileStatus.value = Status.loading;

    await repository.createTeacherProfile(req).then((data) {
      createProfileStatus.value = Status.idle;
    }).catchError((e) {
      createProfileStatus.value = Status.idle;
      throw e;
    });
  }

  Future<void> getNearTeacher(String? bname, int pageNumber) async {
    await repository.getNearTeacher(bname, pageNumber).then((data) {
      teachers = data;
    });
  }

  Future<void> getAvailableArea(int teacherProfileId) async {
    getAvailableAreaStatus.value = Status.loading;
    await repository.getAvailableArea(teacherProfileId).then((data) {
      getAvailableAreaStatus.value = Status.success;
      availableAreas = data;
    }).catchError((e) {
      getAvailableAreaStatus.value = Status.fail;
      getAvailableAreaErrorMessage = e.toString();
    });
  }
}