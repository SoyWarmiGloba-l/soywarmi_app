import 'package:equatable/equatable.dart';

import '../../../core/failures.dart';
import '../../../domain/entity/chat_conversations_entity.dart';

abstract class CreateChatConversationsState extends Equatable {
  const CreateChatConversationsState();

  @override
  List<Object> get props => [];
}

class CreateChatConversationsInitial extends CreateChatConversationsState {}

class CreateChatConversationsLoading extends CreateChatConversationsState {}

class CreateChatConversationsSuccess extends CreateChatConversationsState {
  final String id;

  const CreateChatConversationsSuccess({required this.id});

  @override
  List<Object> get props => [id];
}

class CreateChatConversationsFailed extends CreateChatConversationsState {
  final String message;

  CreateChatConversationsFailed(CreateChatConversationFailure failure) : message = failure.message;
  @override
  List<Object> get props => [message];
}
