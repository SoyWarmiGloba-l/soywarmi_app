import 'package:equatable/equatable.dart';

class ChatConversationsEntity extends Equatable {
  final int id_chat_conversations;
  final int id_type_chat_conversations;
  final String name;
  final int unread_messages_count;
  final dynamic last_message;
  final dynamic last_message_date;

  const ChatConversationsEntity({
    required this.id_chat_conversations,
    required this.id_type_chat_conversations,
    required this.name,
    required this.unread_messages_count,
    required this.last_message,
    required this.last_message_date,
  });

  @override
  List<Object?> get props => [
    id_chat_conversations,
    id_type_chat_conversations,
    name,
    unread_messages_count,
    last_message,
    last_message_date,

  ];
}