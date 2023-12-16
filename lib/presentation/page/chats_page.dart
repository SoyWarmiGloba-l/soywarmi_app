import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soywarmi_app/domain/entity/chat_conversations_entity.dart';
import 'package:soywarmi_app/presentation/widget/chat_card.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';
import '../../core/inyection_container.dart';
import '../bloc/chat_conversations/get_chat_conversations_cubit.dart';
import '../bloc/chat_conversations/get_chat_conversations_state.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetChatConversationsCubit, GetChatConversationsState>(
      bloc: sl<GetChatConversationsCubit>()..getChatConversations(),
      builder: (context, state){
        if (state is GetChatConversationsLoaded) {
          return ChatConversationsList(chatsList: state.chat_conversations);
        }
        if (state is GetChatConversationsError) {
          /*return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.blue,
                  size: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  state.message,
                  style: const TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ],
            ),
          );*/
          return const SingleChildScrollView(
            child: Column(children: [ChatCard(), ChatCard(), ChatCard()]),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }
}
class ChatConversationsList extends StatelessWidget {
  final List<ChatConversationsEntity> chatsList;

  const ChatConversationsList({super.key, required this.chatsList});
  /*return const SingleChildScrollView(
  child: Column(children: [ChatCard(), ChatCard(), ChatCard()]),
  );*/
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatsList.length,
      itemBuilder: (context, index) {
        return ChatCard();
      },
    );
  }
}