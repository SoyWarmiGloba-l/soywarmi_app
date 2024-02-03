import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soywarmi_app/presentation/page/chats_page.dart';
import 'package:soywarmi_app/presentation/page/main_page.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';
import 'package:pusher_client_fixed/pusher_client_fixed.dart';
import 'package:http/http.dart' as http;

import '../../domain/entity/chat_conversations_entity.dart';

bool isPusherConnected = false;

class ChatPage extends StatefulWidget {
  final String id;
  final String name;
  ChatPage(this.id,this.name);

  @override
  State<ChatPage> createState() => _ChatPageState(this.id,this.name);
}

class _ChatPageState extends State<ChatPage> {
  final String id;
  final String name;
  _ChatPageState(this.id,this.name);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //GET http://127.0.0.1:8000/api/get_messages/5
    obtainMessagesConversation();
    connect();
    checkMessagesRead();
    /*if (!isPusherConnected) {
      connect();
      isPusherConnected = true;
    }*/
  }
  @override
  void dispose() {
    // channel.unbind(eventName); // Replace with your event name
    pusher.unsubscribe("mensajes."+id); // Replace with your channel name
    //pusher.disconnect();
    super.dispose();
  }
  checkMessagesRead() async{
    final _storage = const FlutterSecureStorage();
    final userToken = await _storage.read(key: 'USER_TOKEN');
    var response = await http.put(
        Uri.parse(dotenv.env["API_ENDPOINT"]!+"/api/v1/check_read_message/"+id),
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
    final _storage = const FlutterSecureStorage();
    final userToken = await _storage.read(key: 'USER_TOKEN');
    var response = await http.post(
        Uri.parse(dotenv.env["API_ENDPOINT"]!+"/api/v1/post_message/"+id),
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
  }
  String uuid="";
  obtainMessagesConversation() async {
    const storage = FlutterSecureStorage();
    final userToken = await storage.read(key: 'USER_TOKEN');
    uuid = (await storage.read(key: 'UUID')).toString();
    print(userToken);
    var response = await http.get(
        Uri.parse(dotenv.env["API_ENDPOINT"]!+ "/api/v1/get_messages/"+id),
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
        host: '53c3-2800-cd0-1604-f000-9b25-348a-cfd2-5f9.ngrok-free.app',
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
    Channel channel3 = pusher.subscribe("mensajes."+id);
    channel3.bind("registro-mensaje", (PusherEvent? event) {
      print(event?.data);
      checkMessagesRead();
      obtainMessagesConversation();
      //obtainMessagesConversation();
      print("Suscripción a 'mensajes de "+id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 1),
          child: Row(children: [
            const Padding(
              padding: EdgeInsets.only(right: 8, left: 8),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(NbImageEmpty),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Text(
                  name.length > 20
                      ? "${name.substring(0, 20)}..."
                      : name,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
          ]),
        ),
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
                  print(uuid);
                  print(mensajes[index]["id"]);

                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: (uuid.toString()==mensajes[index]["id"].toString())?MainAxisAlignment.end:MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 40,
                              ),
                              Text(
                                mensajes[index]["email"].toString(),
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: (uuid.toString()==mensajes[index]["id"].toString())?MainAxisAlignment.end:MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(NbImageEmpty),
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
                                  color:  (uuid.toString()!=mensajes[index]["id"].toString())?Colors.grey[200]:Colors.greenAccent,
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
                            mainAxisAlignment: (uuid.toString()==mensajes[index]["id"].toString())?MainAxisAlignment.end:MainAxisAlignment.start,
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
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            print("Enviando mensaje");
                            postMessage();
                          },
                        ),
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
}
