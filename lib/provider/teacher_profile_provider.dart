import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slost_only1/data/available_area_req.dart';
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

  ValueNotifier<Status> getAvailableAreaStatus = ValueNotifier(Status.loading);
  String getAvailableAreaErrorMessage = "";
  List<AvailableArea> availableAreas = [];

  ValueNotifier<Status> getTeacherProfileStatus = ValueNotifier(Status.loading);
  late TeacherProfile teacherProfile;
  String getTeacherProfileErrorMessage = "";

  ValueNotifier<Status> getMyTeacherProfileStatus = ValueNotifier(Status.loading);
  late MyTeacherProfile myTeacherProfile;
  String getMyTeacherProfileErrorMessage = "";

  ValueNotifier<Status> editProfileStatus = ValueNotifier(Status.idle);

  // Future<void> createProfile(TeacherProfileCreateReq req) async {
  //   createProfileStatus.value = Status.loading;
  //
  //   await repository.createTeacherProfile(req).then((data) {
  //     createProfileStatus.value = Status.idle;
  //     getMyTeacherProfile();
  //   }).catchError((e) {
  //     createProfileStatus.value = Status.idle;
  //     throw e;
  //   });
  // }

  Future<void> editTeacherProfileImage(XFile image) async {
    editProfileStatus.value = Status.loading;

    await repository.editMyTeacherProfileImage(myTeacherProfile.id, image).then((data) {
      getMyTeacherProfile();
      editProfileStatus.value = Status.idle;
    }).catchError((e) {
      editProfileStatus.value = Status.idle;
      throw e;
    });
  }

  Future<void> editTeacherProfile(TeacherProfileEditReq req) async {
    editProfileStatus.value = Status.loading;

    await repository.editMyTeacherProfile(myTeacherProfile.id, req).then((data) {
      getMyTeacherProfile();
      editProfileStatus.value = Status.idle;
    }).catchError((e) {
      editProfileStatus.value = Status.idle;
      throw e;
    });
  }

  Future<void> getTeacherProfileDetails(int id) async {
    getTeacherProfileStatus.value = Status.loading;

    await repository.getTeacherProfile(id).then((data) {
      teacherProfile = data;
      getTeacherProfileStatus.value = Status.success;
    }).catchError((e) {
      getTeacherProfileStatus.value = Status.fail;
      getTeacherProfileErrorMessage = e.toString();
    });
  }

  Future<void> getMyTeacherProfile() async {
    getMyTeacherProfileStatus.value = Status.loading;

    await repository.getMyTeacherProfile().then((data) {
      myTeacherProfile = data;
      getMyTeacherProfileStatus.value = Status.success;
    }).catchError((e) {
      getMyTeacherProfileStatus.value = Status.fail;
      getTeacherProfileErrorMessage = e.toString();
    });
  }

  Future<PagedData<TeacherProfile>> getNearTeacher(AreaListReq? req, int pageNumber) {
    return repository.getNearTeacher(req, pageNumber);
  }

  Future<void> getAvailableArea(int teacherProfileId) async {
    getAvailableAreaStatus.value = Status.loading;
    await repository.getAvailableArea(teacherProfileId).then((data) {
      availableAreas = data;
      getAvailableAreaStatus.value = Status.success;
    }).catchError((e) {
      getAvailableAreaStatus.value = Status.fail;
      getAvailableAreaErrorMessage = e.toString();
    });
  }
}
