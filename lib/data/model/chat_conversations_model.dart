
import 'package:equatable/equatable.dart';

class ChatConversationsModel extends Equatable{
  final int id_chat_conversation;
  final String name;
  final int id_type_chat_conversations;
  const ChatConversationsModel({
    required this.id_chat_conversation,
    required this.name,
    required this.id_type_chat_conversations,
  });
  factory ChatConversationsModel.fromJson(Map<String, dynamic> json) {
    return ChatConversationsModel(
      id_chat_conversation: json['id_chat_conversation'] as int,
      name: json['name'] as String,
      id_type_chat_conversations: json['id_type_chat_conversations'] as int,
    );
  }

  @override
  List<Object?> get props => [
    id_chat_conversation,
    name,
    id_type_chat_conversations,
  ];
}