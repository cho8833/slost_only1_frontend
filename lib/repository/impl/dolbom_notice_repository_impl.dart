import 'package:http_interceptor/http_interceptor.dart';
import 'package:slost_only1/data/dolbom_notice_req.dart';
import 'package:slost_only1/model/dolbom_notice.dart';
import 'package:slost_only1/repository/dolbom_notice_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/server_response.dart';
import 'package:slost_only1/support/server_uri.dart';

class DolbomNoticeRepositoryImpl with HttpResponseHandler, ServerUri implements DolbomNoticeRepository {

  DolbomNoticeRepositoryImpl(this.interceptedClient);

  final Client interceptedClient;

  @override
  Future<PagedData<DolbomNotice>> getList(DolbomNoticeListReq req) async {
    Uri uri = getUri("/dolbom-notice", queryParameters: req.toJson());

    Response response = await interceptedClient.get(uri);

    return getPagedData(response, (p0) => DolbomNotice.fromJson(p0)).data;
  }

  @override
  Future<DolbomNotice> create(DolbomNoticeCreateReq req) async {
    Uri uri = getUri("/dolbom-notice");

    Response response = await interceptedClient.post(uri, body: req.toJson());

    return getData(response, (p0) => DolbomNotice.fromJson(p0)).data;
  }
}