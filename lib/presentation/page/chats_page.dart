import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pusher_client_fixed/pusher_client_fixed.dart';
import 'package:soywarmi_app/domain/entity/chat_conversations_entity.dart';
import 'package:soywarmi_app/presentation/page/search_people_to_group.dart';
import 'package:soywarmi_app/presentation/page/search_person_to_chat.dart';
import 'package:soywarmi_app/presentation/widget/chat_card.dart';
import '../../core/inyection_container.dart';
import '../../utilities/nb_colors.dart';
import '../bloc/chat_conversations/get_chat_conversations_cubit.dart';
import '../bloc/chat_conversations/get_chat_conversations_state.dart';
class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}
class _ChatsPageState extends State<ChatsPage> {
  final _storage = const FlutterSecureStorage();
  String uuid="";
  _ChatsPageState();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }
  Future<void> dispose() async {
    // channel.unbind(eventName); // Replace with your event name
    uuid = (await _storage.read(key: 'UUID')).toString();
    pusher.unsubscribe("chat."+uuid!); // Replace with your channel name
    //pusher.disconnect();
    super.dispose();
  }
  late PusherClient pusher;

  connect() async {
    pusher = PusherClient(
      'app-key', //default is 'app-key', change to production!
      const PusherOptions(
        host: '53c3-2800-cd0-1604-f000-9b25-348a-cfd2-5f9.ngrok-free.app', //you soketi server ip
        wssPort: 443,
        wsPort: 80, // port is 6001 by default
        encrypted: true, // true for use SSL
      ),
      autoConnect: false,
      enableLogging: true,
    );
    uuid = (await _storage.read(key: 'UUID')).toString();
    Channel channel3 = pusher.subscribe("chat."+uuid!);
    channel3.bind("nuevos-mensajes-chat", (PusherEvent? event) {
      print("-------------------------------------------------------------------------------------------------------------");
      print(event?.data);
      sl<GetChatConversationsCubit>().getChatConversations();
    });
  }
  List<ChatConversationsEntity> aux=[];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetChatConversationsCubit, GetChatConversationsState>(
      bloc: sl<GetChatConversationsCubit>()..getChatConversations(),
      builder: (context, state){
        if (state is GetChatConversationsLoaded) {
          aux=state.chat_conversations;
          return ChatConversationsList(chatsList: state.chat_conversations);
        }

        if (state is GetChatConversationsError) {
          return Center(
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
          );

        }

        return ChatConversationsList(chatsList: aux);
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
    return Stack(
      children: [
        ListView.builder(
          itemCount: chatsList.length,
          itemBuilder: (context, index) {
            return ChatCard(chatsList[index]);
          },
        ),
        Positioned(
          bottom: 20,right: 20,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: NBSecondPrimaryColor,
                ),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPersonToChat()),
                    );
                  },
                  icon: const Icon(Icons.person_add_alt_1, size: 32),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: NBSecondPrimaryColor,
                ),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPeopleToGroup()),
                    );
                  },
                  icon: const Icon(Icons.group_add, size: 32),
                ),
              ),
            ],
          ),
        )
      ]
    );
  }
}