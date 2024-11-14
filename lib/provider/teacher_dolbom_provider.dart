import 'package:flutter/cupertino.dart';
import 'package:slost_only1/data/page_req.dart';
import 'package:slost_only1/enums/dolbom_status.dart';
import 'package:slost_only1/model/dolbom.dart';
import 'package:slost_only1/repository/dolbom_repository.dart';
import 'package:slost_only1/support/server_response.dart';
import 'package:status_builder/status_builder.dart';

class TeacherDolbomProvider {
  TeacherDolbomProvider(this.dolbomRepository);

  final DolbomRepository dolbomRepository;

  ValueNotifier<Status> applyDolbomStatus = ValueNotifier(Status.idle);

  Future<PagedData<Dolbom>> getMatchingDolbom(int page,
      {String? sido, String? sigungu}) {
    return dolbomRepository.getMatchingDolbom(
        sido: sido, sigungu: sigungu, pageReq: PageReq(page, 10));
  }

  Future<PagedData<Dolbom>> getAppliedDolbom(int page) {
    return dolbomRepository.getAppliedDolbom(pageReq: PageReq(page, 10));
  }

  Future<PagedData<Dolbom>> getMyDolbom(DolbomStatus status, int page) {
    return dolbomRepository.getTeacherDolbom(status: status, pageReq: PageReq(page, 10));
  }

  Future<void> applyDolbom(int dolbomId) async {
    applyDolbomStatus.value = Status.loading;
    await dolbomRepository.applyDolbom(dolbomId).then((_) {
      applyDolbomStatus.value = Status.idle;
    }).catchError((e) {
      applyDolbomStatus.value = Status.idle;
      throw e;
    });
  }

}
