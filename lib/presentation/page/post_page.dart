import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pusher_client_fixed/pusher_client_fixed.dart';
import 'package:soywarmi_app/domain/entity/publications_entity.dart';
import 'package:soywarmi_app/presentation/widget/custom_comment.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';

import '../../data/model/comments_model.dart';
import '../../data/remote/http_headers_global.dart';
import '../widget/custom_alerts.dart';
import 'package:intl/intl.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key, required this.publication});
  final PublicationEntity publication;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  List comments=[];
  final _storage = const FlutterSecureStorage();
  final _endPoint = dotenv.env['API_ENDPOINT'];
  void initState() {
    // TODO: implement initState
    super.initState();
    obtainCommentsPublication();
    connect();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    pusher.unsubscribe("comentarios"+widget.publication.id.toString());
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
    var uuid = widget.publication.id;
    pusher.connect();
    Channel channel3 = pusher.subscribe("comentarios"+uuid.toString());
    channel3.bind("registro-comentario", (PusherEvent? event) {
      print("OBTAIN COMMENTS PUBLICATION-------------------------------------------------------------------------------------------------------------");
      obtainCommentsPublication();
    });
    pusher.onConnectionStateChange((state) {
      print(
          "previousState: ${state?.previousState}, currentState: ${state?.currentState}");
      if (state?.currentState == 'CONNECTED') {
        print("CONNECTING TO PUSHER EVENT");
      }
    });
    pusher.onConnectionError((error) {
      print("error: ${error?.exception}  ${error?.code} ${error?.message}");
    });
  }
  TextEditingController controllerContentComment=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                 Row(children: [
                   (widget.publication.ownerPhoto=="")? Container(
                     height: 10,
                     width: 10,
                     padding: const EdgeInsets.only(right: 8, left: 8),
                     child: const CircleAvatar(
                       radius: 20,
                       backgroundColor: Colors.transparent,
                       backgroundImage: AssetImage(NbImageEmpty),
                     ),
                   ):Container(
                     width: 50,
                     height: 50,
                     margin: const EdgeInsets.symmetric(horizontal: 5),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(100),
                       image: DecorationImage(
                         image: NetworkImage(widget.publication.ownerPhoto),
                         fit: BoxFit.cover,
                       ),
                     ),
                     child: const Text(""),
                   ),
                  const SizedBox(width: 12),
                  Text(
                    widget.publication.ownerName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.publication.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                      Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.publication.content,
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.5),
                    ),
                  ),
                ),
                (widget.publication.images.isNotEmpty)?CarouselSlider.builder(
                  itemCount: widget.publication.images.length,
                  options: CarouselOptions(
                    height: 300.0,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final image = widget.publication.images[index];

                    return Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: const BoxDecoration(
                              color: Colors.amber,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(image, fit: BoxFit.cover)),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ],
                    );
                  },
                ):const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      /*Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '13',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),*/
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.publication.numberComments.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listCommentsModel.length,
                  itemBuilder: (context, index) {
                    final commentModel = listCommentsModel[index];
                    return CustomComment(comment: commentModel);
                  },
                ),
              ]),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.1,
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
                            controller: controllerContentComment,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Escribe un comentario...',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            print("Register");
                            registerPublication();
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: NbSecondSecondaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.send,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  List<CommentsModel> listCommentsModel=[];
  Future<void> obtainCommentsPublication() async {
    final userToken = await _storage.read(key: 'USER_TOKEN');
    await HttpHeadersGlobal.headerGetHttpWithToken(userToken!, '$_endPoint/api/v1/comments/publication/${widget.publication.id}').then((res){
      if(res.statusCode==200){
        setState(() {
          comments=jsonDecode(res.body)['data'];
          print(comments);
          if (comments.isNotEmpty) {
            setState(() {
              listCommentsModel = comments.map((e) => CommentsModel.fromJson(e)).toList();
            });
          }
        });
      }else{
        CustomAlerts.showErrorDialog(context, "Error al obtener los comentarios");
      }
    });
  }

  Future<void> registerPublication() async {
    final userToken = await _storage.read(key: 'USER_TOKEN');
    final account = await _storage.read(key: 'my_account');
    print(account);
    final dateNow= DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSZ").format(DateTime.now());
    if(account!=null){
      final body=jsonEncode({
        "person_id": json.decode(account)['id'],
        "publication_id": widget.publication.id,
        "content": controllerContentComment.text,
        "state": "",
        "created_at": dateNow,
        "updated_at": dateNow,
        "deleted_at": null
      });
      await HttpHeadersGlobal.headerPostHttpWithToken(userToken!, '$_endPoint/api/v1/comments',body).then((res){
        if(res.statusCode==200){
          setState(() {
            obtainCommentsPublication();
          });
        }else{
          CustomAlerts.showErrorDialog(context, "Error al registrar comentario");
        }
      });
    }

  }
}
