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
           id_chat_conversations: e.id_chat_conversations,
           name: e.name,
           type_chat_conversations: e.type_chat_conversations,
        );
      });

      return Right(chatConversationsEntity.toList());

    } on Exception{
      return Left(ChatConversationsFailure('Error al obtener las noticias'));


    }
  }

}