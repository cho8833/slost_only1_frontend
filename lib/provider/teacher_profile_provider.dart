import 'package:flutter/cupertino.dart';
import 'package:slost_only1/data/teacher_profile_req.dart';
import 'package:slost_only1/repository/teacher_profile_repository.dart';
import 'package:status_builder/status_builder.dart';

class TeacherProfileProvider {

  final TeacherProfileRepository repository;

  TeacherProfileProvider(this.repository);

  ValueNotifier<Status> createProfileStatus = ValueNotifier(Status.idle);



  Future<void> createProfile(TeacherProfileCreateReq req) async {
    createProfileStatus.value = Status.loading;

    await repository.createTeacherProfile(req).then((data) {
      createProfileStatus.value = Status.idle;
    }).catchError((e) {
      createProfileStatus.value = Status.idle;
      throw e;
    });
  }


}