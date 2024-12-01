import 'package:slost_only1/model/member.dart';

abstract interface class ChatRepository {

  Future<Member> createSendbirdUser();
}