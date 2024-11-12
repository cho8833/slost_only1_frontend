import 'package:flutter/cupertino.dart';
import 'package:slost_only1/data/kid_req.dart';
import 'package:slost_only1/enums/gender.dart';
import 'package:slost_only1/model/kid.dart';
import 'package:slost_only1/repository/kid_repository.dart';
import 'package:status_builder/status_builder.dart';

class KidProvider {
  final KidRepository kidRepository;

  KidProvider(this.kidRepository);

  List<Kid> myKids = [];
  ValueNotifier<Status> getMyKidsStatus = ValueNotifier(Status.loading);
  String getMyKidsErrorMessage = "";

  ValueNotifier<Status> addKidStatus = ValueNotifier(Status.idle);

  ValueNotifier<Status> deleteKidStatus = ValueNotifier(Status.idle);

  ValueNotifier<Status> editKidStatus = ValueNotifier(Status.idle);

  Future<void> getMyKids() async {
    getMyKidsStatus.value = Status.loading;
    await kidRepository.getMyKidList().then((kids) {
      myKids = kids;
      getMyKidsStatus.value = Status.success;
    }).catchError((e) {
      getMyKidsErrorMessage = e.toString();
      getMyKidsStatus.value = Status.fail;
    });
  }
  Future<void> addKid(KidCreateReq req) async {
    await kidRepository.addKid(req).then((result) {
      getMyKids();
      addKidStatus.value = Status.success;
    });
  }

  Future<void> editKid(KidEditReq req) async {
    await kidRepository.editKid(req).then((result) {
      getMyKids();
      editKidStatus.value = Status.success;
    });
  }

  Future<void> deleteKid(int id) async {
    await kidRepository.deleteKid(id).then((_) {
      getMyKids();
      deleteKidStatus.value = Status.success;
    });
  }

  String? validateKidInfo(String? name, Gender? gender, DateTime? birthday) {
    if (name == null || gender == null || birthday == null) {
      return "필수 입력항목을 확인해주세요";
    }
    if (name!.isEmpty) {
      return "이름을 입력해주세요";
    }
    return null;
  }
}