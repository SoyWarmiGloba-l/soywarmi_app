import 'package:equatable/equatable.dart';

import '../../../domain/entity/chat_conversations_entity.dart';

abstract class GetChatConversationsState extends Equatable {
  const GetChatConversationsState();

  @override
  List<Object> get props => [];
}

class GetChatConversationsInitial extends GetChatConversationsState {}

class GetChatConversationsLoading extends GetChatConversationsState {}

class GetChatConversationsLoaded extends GetChatConversationsState {
  final List<ChatConversationsEntity> chat_conversations;

  const GetChatConversationsLoaded({required this.chat_conversations});

  @override
  List<Object> get props => [chat_conversations];
}

class GetChatConversationsError extends GetChatConversationsState {
  final String message;

  const GetChatConversationsError({required this.message});

  @override
  List<Object> get props => [message];
}
