import 'package:http/http.dart';
import 'package:slost_only1/repository/notice_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/server_uri.dart';

class NoticeRepositoryImpl with HttpResponseHandler,ServerUri implements NoticeRepository {
  final Client interceptedClient;

  NoticeRepositoryImpl(this.interceptedClient);

  @override
  Future<String> getAnnouncementUrl() async {
    Uri uri = getUri("/notice/announcement");
    
    Response response = await interceptedClient.get(uri);
    
    return getData(response, (p) => NoticeRes.fromJson(p)).data.url;
  }

  @override
  Future<String> getFAQUrl() async {
    Uri uri = getUri("/notice/faq");

    Response response = await interceptedClient.get(uri);

    return getData(response, (p) => NoticeRes.fromJson(p)).data.url;
  }

  @override
  Future<String> getTermsUrl() async {
    Uri uri = getUri("/notice/terms");

    Response response = await interceptedClient.get(uri);

    return getData(response, (p) => NoticeRes.fromJson(p)).data.url;
  }

  @override
  Future<String> getPrivacyUrl() async {
    Uri uri = getUri("/notice/privacy");

    Response response =  await interceptedClient.get(uri);

    return getData(response, (p) => NoticeRes.fromJson(p)).data.url;
  }
}

class NoticeRes {
  String url;

  NoticeRes(this.url);

  factory NoticeRes.fromJson(Map<String, dynamic> json ) => NoticeRes(json['url']);
}