import 'package:slost_only1/model/dolbom_notice.dart';
import 'package:slost_only1/support/server_response.dart';

abstract interface class DolbomNoticeRepository {
  Future<PagedData<DolbomNotice>> getList({ String? sido, String? sigungu, String? bname });
}
