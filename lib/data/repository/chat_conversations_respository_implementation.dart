import 'package:dartz/dartz.dart';
import 'package:soywarmi_app/domain/entity/chat_conversations_entity.dart';

import '../../core/failures.dart';
import '../../domain/repository/chat_conversations_repository.dart';
import '../remote/chat_conversations_data_source.dart';

class ChatConversationsRepositoryImplementation extends ChatConversationsRepository {

  ChatConversationsRepositoryImplementation({
    required this.chatConversationsDataSource,
  });


  final ChatConversationsDataSource chatConversationsDataSource;
  @override
  Future<Either<ChatConversationsFailure, List<ChatConversationsEntity>>> getChatConversations() async {
    try {
      final chatConversationsModel = await chatConversationsDataSource.getChatConversations();

      final chatConversationsEntity = chatConversationsModel.map((e) {
        return ChatConversationsEntity(
           id_chat_conversations: e.id_chat_conversation,
           name: e.name,
           id_type_chat_conversations: e.id_type_chat_conversations,
          last_message:e.last_message,
          last_message_date: e.last_message_date,
          unread_messages_count: e.unread_messages_count
        );
      });

      return Right(chatConversationsEntity.toList());

    } on Exception{
      return Left(ChatConversationsFailure('Error al obtener las noticias'));


    }
  }

}