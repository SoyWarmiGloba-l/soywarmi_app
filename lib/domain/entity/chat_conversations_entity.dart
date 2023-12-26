import 'package:equatable/equatable.dart';

class ChatConversationsEntity extends Equatable {
  final int id_chat_conversations;
  final String name;
  final int id_type_chat_conversations;

  const ChatConversationsEntity({
    required this.id_chat_conversations,
    required this.name,
    required this.id_type_chat_conversations,
  });

  @override
  List<Object?> get props => [
    id_chat_conversations,
    name,
    id_type_chat_conversations,
  ];
}