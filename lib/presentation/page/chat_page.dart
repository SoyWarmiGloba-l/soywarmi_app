import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:soywarmi_app/presentation/page/main_page.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';
import 'package:pusher_client_fixed/pusher_client_fixed.dart';
import 'package:http/http.dart' as http;

import '../../data/remote/http_headers_global.dart';
import '../widget/custom_alerts.dart';

bool isPusherConnected = false;

class ChatPage extends StatefulWidget {
  final String chatConversationId;
  final String chatConversationName;
  const ChatPage(this.chatConversationId,this.chatConversationName, {super.key});

  @override
  State<ChatPage> createState() => _ChatPageState(this.chatConversationId,this.chatConversationName);
}

class _ChatPageState extends State<ChatPage> {
  final String chatConversationId;
  final String chatConversationName;
  _ChatPageState(this.chatConversationId,this.chatConversationName);
  bool isMessageLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //GET http://127.0.0.1:8000/api/get_messages/5
    obtainMyAccount();
    obtainMessagesConversation();
    connect();
    checkMessagesRead();
    /*if (!isPusherConnected) {
      connect();
      isPusherConnected = true;
    }*/
  }
  final storage = const FlutterSecureStorage();
  Map<dynamic,dynamic> myAccount={
    "name":""
  };
  Future<void> obtainMyAccount() async {
    final myAccountJson = await storage.read(key: 'my_account');
    if (myAccountJson != null) {
      setState(() {
        myAccount=jsonDecode(myAccountJson);
      });
    }
  }
  @override
  void dispose() {
    // channel.unbind(eventName); // Replace with your event name
    pusher.unsubscribe("mensajes."+chatConversationId); // Replace with your channel name
    //pusher.disconnect();
    super.dispose();
  }
  checkMessagesRead() async{
    final _storage = const FlutterSecureStorage();
    final userToken = await _storage.read(key: 'USER_TOKEN');
    var response = await http.put(
        Uri.parse(dotenv.env["API_ENDPOINT"]!+"/api/v1/check_read_message/"+chatConversationId),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $userToken'
        });
    print("PUT CHECK MESSAGE"+response.statusCode.toString());
    if (response.statusCode == 200) {
      obtainMessagesConversation();
    }
  }
  postMessage() async {
    setState(() {
      isMessageLoading=true;
    });
    if(mensage_input.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se puede enviar un mensaje vacio')),
      );
      setState(() {
        isMessageLoading=false;
      });
      return;
    }
    const storage = FlutterSecureStorage();
    final userToken = await storage.read(key: 'USER_TOKEN');
    var response = await http.post(
        Uri.parse(dotenv.env["API_ENDPOINT"]!+"/api/v1/post_message/"+chatConversationId),
        body: jsonEncode({
          "content":mensage_input.text
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $userToken'
        });
    print("POST MESSAGE"+response.statusCode.toString());
    if (response.statusCode == 200) {
    }
    setState(() {
      isMessageLoading=false;
    });
  }
  dynamic my_account="";
  obtainMessagesConversation() async {
    const storage = FlutterSecureStorage();
    final userToken = await storage.read(key: 'USER_TOKEN');
    my_account = json.decode((await storage.read(key: 'my_account')).toString());
    print(userToken);
    var response = await http.get(
        Uri.parse(dotenv.env["API_ENDPOINT"]!+ "/api/v1/get_messages/"+chatConversationId),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $userToken'
        });
    print("GET MESSAGE"+response.statusCode.toString());

    if (response.statusCode == 200) {
      setState(() {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        mensajes=jsonResponse["data"];
      });
    }
  }
  List mensajes=[];
  TextEditingController mensage_input=TextEditingController();
  late PusherClient pusher;
  connect() {
    print("CONNECT CHAT PAGE NEW");
    pusher = PusherClient(
      'app-key', //default is 'app-key', change to production!
      PusherOptions(
        host: '${dotenv.env["SOCKET_ENDPOINT"]}',
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
    Channel channel3 = pusher.subscribe("mensajes."+chatConversationId);
    channel3.bind("registro-mensaje", (PusherEvent? event) {
      print(event?.data);
      obtainMessagesConversation();
      checkMessagesRead();
      //obtainMessagesConversation();
      print("Suscripción a 'mensajes de "+chatConversationId);
    });
    Channel channel4 = pusher.subscribe("chat."+chatConversationId);
    channel4.bind("chat-eliminado", (PusherEvent? event) {
      CustomAlerts.showInfoDialog(context, "Chat eliminado", "El chat fue eliminado por el creador del chat");
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(selectedIndex: 4)));
    });
  }
  final GlobalKey<_ChatPageState> chatPageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: chatPageKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
            const Padding(
              padding: EdgeInsets.only(right: 8, left: 8),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(NbImageEmpty),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.4,
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  chatConversationName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
          ]),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            iconSize: 20,
            onPressed: () {
              deleteChatConversation();
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatEditPage(widget.id)),
              );*/
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(selectedIndex: 4)));
          },
        ),
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ClipRRect(
              child: ListView.builder(
                reverse: true,
                itemCount: mensajes.length,
                itemBuilder: (context, index) {
                  print("MOSTRAR MENSAJES-------------------------------------------------------------------------------");
                  print(my_account);
                  print(mensajes[index]);
                  String imageOwnerPhoto=mensajes[index]["owner_photo"].toString();
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: (my_account["email"].toString()==mensajes[index]["owner_email"].toString())?MainAxisAlignment.end:MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 40,
                              ),
                              Text(
                                mensajes[index]["owner_email"].toString(),
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 12),
                              ),
                              (my_account["email"].toString()==mensajes[index]["owner_email"].toString())?IconButton(onPressed: (){deleteMessage(mensajes[index]["id"]);}, icon: Icon(Icons.delete,size: 20,)):SizedBox()
                              /*(my_account["id"]==id.personId)?IconButton(
                                  onPressed: () {
                                    deletePost();
                                  },
                                  icon: Icon(Icons.delete)
                              ):SizedBox()*/
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: (my_account["email"].toString()==mensajes[index]["owner_email"].toString())?MainAxisAlignment.end:MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage((imageOwnerPhoto=="")?'$_endPoint/storage/default_image.png':"$_endPoint$imageOwnerPhoto"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.6),
                              decoration: BoxDecoration(
                                  color:  (my_account["email"].toString()!=mensajes[index]["owner_email"].toString())?Colors.grey[200]:Colors.greenAccent,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(12),
                                  )),
                              child: Text(
                                mensajes[index]["content"].toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: (my_account["email"].toString()==mensajes[index]["owner_email"].toString())?MainAxisAlignment.end:MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 40,
                              ),
                              Text(
                                mensajes[index]["created_at"].toString(),
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 12),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          color: Colors.white,
          height: 100,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: mensage_input,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Escribe tu mensaje ...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: NbSecondSecondaryColor,
                        child: (!isMessageLoading)?IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            postMessage();
                          },
                        ):const CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
  final _storage = const FlutterSecureStorage();
  final _endPoint = dotenv.env['API_ENDPOINT'];
  Future<void> deleteMessage(messageId) async {
    print("DELETE MESSAGE------------------------------------------");
    print(messageId);
    final userToken = await _storage.read(key: 'USER_TOKEN');
    CustomAlerts.showConfirmationDialog(chatPageKey.currentContext!).then((value) async => {
      if(value){
        await HttpHeadersGlobal.headerDeleteHttpWithToken(userToken!, '$_endPoint/api/v1/chat_messages_participation/${messageId}').then((res){
          if(res.statusCode==200){
            CustomAlerts.showSuccessDialog(chatPageKey.currentContext!, "Mensaje eliminado","Mensaje eliminado exitosamente");
          }else{
            CustomAlerts.showErrorDialog(chatPageKey.currentContext!, "Error al eliminar mensaje");
          }
        })
      }
    });
  }

  Future<void> deleteChatConversation() async {
    final userToken = await _storage.read(key: 'USER_TOKEN');
    CustomAlerts.showConfirmationDialog(chatPageKey.currentContext!).then((confirmation) async => {
      await HttpHeadersGlobal.headerDeleteHttpWithToken(userToken!, '$_endPoint/api/v1/chat_conversations/$chatConversationId').then((res){
        if(res.statusCode==200){
          CustomAlerts.showSuccessDialog(chatPageKey.currentContext!, "Chat eliminado","Chat eliminado exitosamente");
          return;
        }
        if(res.statusCode==403){
          CustomAlerts.showErrorDialog(chatPageKey.currentContext!, "No tiene permiso de eliminar el chat");
          return;
        }
        CustomAlerts.showErrorDialog(chatPageKey.currentContext!, "Error al eliminar chat");
      })
    });
  }
}
