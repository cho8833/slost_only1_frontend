import 'package:slost_only1/data/dolbom_notice_req.dart';
import 'package:slost_only1/model/dolbom_notice.dart';
import 'package:slost_only1/support/server_response.dart';

abstract interface class DolbomNoticeRepository {
  Future<PagedData<DolbomNotice>> getList(DolbomNoticeListReq req);

  Future<DolbomNotice> create(DolbomNoticeCreateReq req);
}
