

import 'package:dartz/dartz.dart';
import 'package:soywarmi_app/core/failures.dart';

import '../../../core/usecases.dart';
import '../../entity/chat_conversations_entity.dart';
import '../../entity/user_entity.dart';
import '../../repository/chat_conversations_repository.dart';

class CreateChatConversationsUseCase extends FutureUsesCase<void, CreateChatConversationsParams> {
  CreateChatConversationsUseCase({
    required ChatConversationsRepository chatConversationsRepository,
  }) : _chatConversationsRepository = chatConversationsRepository;

  final ChatConversationsRepository _chatConversationsRepository;
  @override
  Future<Either<CreateChatConversationFailure, String>> call(CreateChatConversationsParams params) {
    return _chatConversationsRepository.createChatConversation(
      name: params.name,
      users: params.users,
    );
  }

}
class CreateChatConversationsParams {
  const CreateChatConversationsParams({this.name,this.users});
  final String? name;
  final List<String>? users;
}