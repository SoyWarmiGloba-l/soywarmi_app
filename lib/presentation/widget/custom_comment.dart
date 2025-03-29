
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soywarmi_app/data/model/comments_model.dart';
import 'package:soywarmi_app/presentation/widget/custom_alerts.dart';

import '../../data/remote/http_headers_global.dart';
import '../../utilities/nb_colors.dart';
import '../../utilities/nb_images.dart';

class CustomComment extends StatelessWidget {
  CommentsModel comment;
  String idUser;
  GlobalKey postPageKey;
  final _endPoint = dotenv.env['API_ENDPOINT'];
  CustomComment({super.key, required this.comment,required this.idUser,required this.postPageKey});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: Row(
        children: [
           Padding(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 18,
              backgroundImage:NetworkImage("${comment.ownerPhoto}"),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width>800?MediaQuery.of(context).size.width*0.5:MediaQuery.of(context).size.width*0.7,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: NbSecondSecondaryColor,
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8,top: 8,right: 8,bottom: 4),
                        child: Text(comment.ownerName,style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    (idUser==comment.personId.toString())?Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: (){
                          deleteComment(comment.id);
                        },
                        icon: const Icon(Icons.delete,size: 20,),
                      ),
                    ):const SizedBox(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8,top: 4,right: 8,bottom: 8),
                  child: Text(comment.content),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  final _storage = const FlutterSecureStorage();
  Future<void> deleteComment(int id) async {
    final userToken = await _storage.read(key: 'USER_TOKEN');
    CustomAlerts.showConfirmationDialog(postPageKey.currentContext!).then((value) async => {
      if(value){
        await HttpHeadersGlobal.headerDeleteHttpWithToken(userToken!, '$_endPoint/api/v1/comments/${comment.id}').then((res){
        if(res.statusCode==200){
          CustomAlerts.showSuccessDialog(postPageKey.currentContext!, "Comentario eliminado","Comentario eliminado exitosamente");
        }else{
          CustomAlerts.showErrorDialog(postPageKey.currentContext!, "Error al eliminar comentario");
        }
       })
      }
    });
  }
}
