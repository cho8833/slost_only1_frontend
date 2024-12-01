import 'package:http/http.dart';
import 'package:slost_only1/model/member.dart';
import 'package:slost_only1/repository/chat_repository.dart';
import 'package:slost_only1/support/http_response_handler.dart';
import 'package:slost_only1/support/server_uri.dart';

class ChatRepositoryImpl with ServerUri, HttpResponseHandler implements ChatRepository {
  ChatRepositoryImpl(this.interceptedClient);

  final Client interceptedClient;

  @override
  Future<Member> createSendbirdUser() async {
    Uri uri = getUri("/sendbird/user");

    Response response = await interceptedClient.put(uri);
    
    return getData(response, (p) => Member.fromJson(p)).data;
  }

}