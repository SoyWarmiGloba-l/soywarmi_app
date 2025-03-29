import 'package:flutter/material.dart';
import 'package:soywarmi_app/domain/entity/chat_conversations_entity.dart';
import 'package:soywarmi_app/presentation/page/chat_page.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';

class ChatCard extends StatelessWidget {

  final ChatConversationsEntity chatConversation;

  const ChatCard(this.chatConversation, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatPage(chatConversation.id_chat_conversations.toString(),chatConversation.name.toString())),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: NbSecondSecondaryColor.withOpacity(0.5), width: 1.0)),
        ),
        child: Row(children: [
          const Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(NbImageEmpty),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  chatConversation.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  chatConversation.last_message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (chatConversation.unread_messages_count!=0)?
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: NBSecondPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      chatConversation.unread_messages_count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ):Container(),
                  const SizedBox(height: 8),
                  Text(
                      (chatConversation.last_message_date==null)?"":chatConversation.last_message_date.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
