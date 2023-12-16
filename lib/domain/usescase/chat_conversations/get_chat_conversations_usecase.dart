import 'package:dartz/dartz.dart';
import 'package:soywarmi_app/core/failures.dart';
import 'package:soywarmi_app/domain/entity/chat_conversations_entity.dart';

import '../../../core/usecases.dart';
import '../../repository/chat_conversations_repository.dart';

class GetChatConversationsUseCase extends FutureUsesCase<List<ChatConversationsEntity>, NoParams> {
  GetChatConversationsUseCase({
    required this.chatConversationsRepository,
  });
  final ChatConversationsRepository chatConversationsRepository;

  @override
  Future<Either<ChatConversationsFailure, List<ChatConversationsEntity>>> call(NoParams params) {
    return chatConversationsRepository.getChatConversations();
  }

}