import 'package:flutter/cupertino.dart';
import 'package:slost_only1/data/dolbom_notice_req.dart';
import 'package:slost_only1/model/dolbom_notice.dart';
import 'package:slost_only1/repository/dolbom_notice_repository.dart';
import 'package:status_builder/status_builder.dart';

class DolbomNoticeProvider {
  List<DolbomNotice> notices = [];

  final DolbomNoticeRepository repository;
  ValueNotifier<Status> getNoticesStatus = ValueNotifier(Status.loading);
  String getNoticesErrorMessage = "";
  ValueNotifier<String?> getNoticeSigungu = ValueNotifier(null);
  int noticePageNumber = 0;

  ValueNotifier<Status> postNoticeStatus = ValueNotifier(Status.loading);

  DolbomNoticeProvider(this.repository);

  Future<void> getList({int? pageNumber, String? sigungu}) async {
    if (pageNumber != null) {
      noticePageNumber = pageNumber;
    }
    if (sigungu != null) {
      getNoticeSigungu.value = sigungu;
    }
    getNoticesStatus.value = Status.loading;
    await repository.getList(DolbomNoticeListReq(sigungu: getNoticeSigungu.value, pageNumber: noticePageNumber)).then((pagedData) {
      notices = pagedData.content;
      getNoticesStatus.value = Status.success;

    }).catchError((e) {
      getNoticesErrorMessage = e.toString();
      getNoticesStatus.value = Status.fail;
    });
  }

  Future<void> postNotice(DolbomNoticeCreateReq req) async {
    await repository.create(req).then((result) {
      postNoticeStatus.value = Status.success;
      getList();
    });
  }
}