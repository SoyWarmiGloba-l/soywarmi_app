
import 'package:equatable/equatable.dart';

class ChatConversationsModel extends Equatable{
  final int id_chat_conversations;
  final String name;
  final String type_chat_conversations;
  const ChatConversationsModel({
    required this.id_chat_conversations,
    required this.name,
    required this.type_chat_conversations,
  });
  factory ChatConversationsModel.fromJson(Map<String, dynamic> json) {
    return ChatConversationsModel(
      id_chat_conversations: json['id'] as int,
      name: json['event_type_id'] as String,
      type_chat_conversations: json['title'] as String,
    );
  }

  @override
  List<Object?> get props => [
    id_chat_conversations,
    name,
    type_chat_conversations,
  ];
}