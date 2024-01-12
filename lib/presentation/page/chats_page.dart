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
    print("CONNECT CHATS PAGE ---------------------------------------------------");
    pusher = PusherClient(
      'app-key', //default is 'app-key', change to production!
      const PusherOptions(

        host: '88d2-2800-cd0-1604-f000-dddb-9198-18af-76e1.ngrok-free.app', //you soketi server ip
        wssPort: 443,
        wsPort: 80, // port is 6001 by default
        encrypted: true, // true for use SSL
        /*auth: PusherAuth(
          'whole-ravens-post.loca.lt/broadcasting/auth', // or you_laravel_endpoint/broadcasting/auth
          headers: {
            'Authorization':
            'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImJlNzgyM2VmMDFiZDRkMmI5NjI3NDE2NThkMjA4MDdlZmVlNmRlNWMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc295d2FybWktZTFhZGQiLCJhdWQiOiJzb3l3YXJtaS1lMWFkZCIsImF1dGhfdGltZSI6MTcwMjQ4ODYxNiwidXNlcl9pZCI6Ik9FS0trSWlPQk9RYUNya3dGcW1UajgyNFowRDIiLCJzdWIiOiJPRUtLa0lpT0JPUWFDcmt3RnFtVGo4MjRaMEQyIiwiaWF0IjoxNzAyNDk2MTM0LCJleHAiOjE3MDI0OTk3MzQsImVtYWlsIjoibW9udGFub2o0N0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJtb250YW5vajQ3QGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.LzxGQ66wicPZzAyngV1Sr2q1c15sU2VqfImzuiYqo2RRM89jjewFOqbU2UInwEDD6Pbs7yZy5gRYMhwGLQix-RsMLdZur2UEoQ4VQc2m1CWp0Ru7SEmQHQow8VzmsO0ULedOkkNquSisOdQXkP2rXmZSBoJ9jJAaXIr85NPPKbodNkOriphHO4BvBswSffOIx_LfjP2PLXAdvAlJyCS3n46gO6dOnWc0WgM3LqY9jzeKQgxg307tYNxbFGChXjTgNKoDK_oJy0xTOs6rehug9UZTEwOiEN2LlLuQYakXbDjGzW1TP_UWjzWA7mxz3u_XOnVEwIq7RpWCey_sYqxAvA', // optional, if using this auth in headers
          },
        ),*/
      ),
      autoConnect: false,
      enableLogging: true,
    );
    uuid = (await _storage.read(key: 'UUID')).toString();
    pusher.connect();
    Channel channel3 = pusher.subscribe("chat."+uuid!);
    channel3.bind("nuevos-mensajes-chat", (PusherEvent? event) {
      print("-------------------------------------------------------------------------------------------------------------");
      print(event?.data);
      sl<GetChatConversationsCubit>().getChatConversations();
    });
    pusher.onConnectionStateChange((state) {
      print(
          "previousState: ${state?.previousState}, currentState: ${state?.currentState}");
      if (state?.currentState == 'CONNECTED') {
        print("CONNECTING TO PUSHER EVENT");

        /*channel3.bind("nuevos-mensajes-chat", (PusherEvent? event) {
          print("-------------------------------------------------------------------------------------------------------------");
          print(event?.data);
          sl<GetChatConversationsCubit>().getChatConversations();
        });*/
        /*channel3.bind("pusher:subscription_succeeded", (PusherEvent? event) {
          obtainMessagesConversation();
          print("Suscripción a 'mensajes-publicos' exitosa");
        });*/

        /*channel3.bind("evento-mensaje", (PusherEvent? event) {
          print("ESCUCHANDO EVENTO sin ID--------------------------------------------------------------------------------------------------------------");
          obtainMessagesConversation();
          print(event?.data);
        });*/
      }
    });

    pusher.onConnectionError((error) {
      print("error: ${error?.exception}  ${error?.code} ${error?.message}");
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