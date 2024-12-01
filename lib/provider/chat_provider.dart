import 'package:slost_only1/model/member.dart';
import 'package:slost_only1/repository/chat_repository.dart';

class ChatProvider {
  ChatProvider(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Member> createSendbirdUser() {
    return _chatRepository.createSendbirdUser();
  }
}