import 'package:dartz/dartz.dart';
import 'package:soywarmi_app/domain/entity/chat_conversations_entity.dart';

import '../../core/failures.dart';
import '../entity/news_entity.dart';

abstract class ChatConversationsRepository {
  Future<Either<ChatConversationsFailure, List<ChatConversationsEntity>>> getChatConversations();
}