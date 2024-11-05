import 'package:flutter/cupertino.dart';
import 'package:slost_only1/model/dolbom_notice.dart';
import 'package:slost_only1/repository/dolbom_notice_repository.dart';
import 'package:status_builder/status_builder.dart';

class DolbomNoticeProvider {
  List<DolbomNotice> notices = [];

  final DolbomNoticeRepository repository;
  ValueNotifier<Status> getNoticesStatus = ValueNotifier(Status.loading);
  String getNoticesErrorMessage = "";

  DolbomNoticeProvider(this.repository);

  Future<void> getList() async {
    await repository.getList().then((pagedData) {
      notices = pagedData.content;
      getNoticesStatus.value = Status.success;

    }).catchError((e) {
      getNoticesErrorMessage = e.toString();
      getNoticesStatus.value = Status.fail;
    });
  }
}