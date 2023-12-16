import 'package:equatable/equatable.dart';

class ChatConversationsEntity extends Equatable {
  final int id_chat_conversations;
  final String name;
  final String type_chat_conversations;

  const ChatConversationsEntity({
    required this.id_chat_conversations,
    required this.name,
    required this.type_chat_conversations,
  });

  @override
  List<Object?> get props => [
    id_chat_conversations,
    name,
    type_chat_conversations,
  ];
}