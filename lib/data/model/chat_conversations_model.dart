
import 'package:equatable/equatable.dart';

class ChatConversationsModel extends Equatable{
  final int id_chat_conversation;
  final int id_type_chat_conversations;
  final String name;
  final int unread_messages_count;
  final dynamic last_message;
  final dynamic last_message_date;


  const ChatConversationsModel({
    required this.id_chat_conversation,
    required this.id_type_chat_conversations,
    required this.name,
    required this.unread_messages_count,
    required this.last_message,
    required this.last_message_date,

  });
  factory ChatConversationsModel.fromJson(Map<String, dynamic> json) {
    return ChatConversationsModel(
      id_chat_conversation: json['id_chat_conversation'] as int,
      id_type_chat_conversations: json['id_type_chat_conversations'] as int,
      name: json['name'] ?? "" as String,
      unread_messages_count: json['unread_messages_count']??0 as int,
      last_message: json['last_message']??"" as dynamic,
      last_message_date: json['last_message_date']??DateTime.now() as dynamic,

    );
  }

  @override
  List<Object?> get props => [
    id_chat_conversation,
    id_type_chat_conversations,
    name,
    unread_messages_count,
    last_message,
    last_message_date,

  ];
}