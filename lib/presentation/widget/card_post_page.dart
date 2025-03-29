import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soywarmi_app/core/language/locales.dart';
import 'package:soywarmi_app/domain/entity/publications_entity.dart';
import 'package:soywarmi_app/presentation/page/post_page.dart';
import 'package:soywarmi_app/presentation/widget/image_max_screen.dart';

import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';

import '../../data/remote/http_headers_global.dart';
import 'custom_alerts.dart';

class CardPostPage extends StatelessWidget {
  CardPostPage({super.key, required this.publication,required this.idUser,required this.postsPageKey});
  final String idUser;
  final PublicationEntity publication;
  final GlobalKey postsPageKey;
  final _endPoint = dotenv.env['API_ENDPOINT'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(0),
        child: Column(children: [
          Row(children: [
            Expanded(
              flex:2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage:NetworkImage((publication.ownerPhoto=="")?'$_endPoint/storage/default_image.png':"$_endPoint${publication.ownerPhoto}"),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                publication.ownerName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostPage(
                              publication: publication,
                            )));
                  },
                  child: Text(
                    LocaleData.ver.getString(context),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
            ),
            (idUser==publication.personId.toString())?IconButton(
                onPressed: () {
                  deletePost();
                },
                icon: Icon(Icons.delete)
            ):SizedBox()
          ]),
          (publication.title!="")?Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              maxLines:2,
              overflow:TextOverflow.ellipsis,
              publication.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Theme.of(context).primaryColorDark.withOpacity(0.5),
              ),
            ),
          ):const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              publication.content,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColorDark.withOpacity(0.5),
              ),
            ),
          ),
          (publication.images.length>0)?CarouselSlider.builder(
            itemCount: publication.images.length,
            options: CarouselOptions(
              height: 300.0,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            ),
            itemBuilder: (context, index, realIndex) {
              final image = publication.images[index];

              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageMaxScreen(urlImage: '$_endPoint$image'),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network('$_endPoint$image', fit: BoxFit.cover)),
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
                ),
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
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),*/
                Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      publication.numberComments.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          /*Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 10),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(NbImageEmpty),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: NbSecondSecondaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                          ' Bienvenido a la comunidad dsfsduiohfsuoidf sduhfsiudfhsuidf sudfhsduifsdfbsdufb sdasdbisbdfsd jshdfsdhfjsvdfhgs sdhfhjsdgf sassdfsd sdfjhsdhfjsd sdfshdfjsdfg'),
                    ),
                  ),
                )
              ],
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostPage(
                              publication: publication,
                            )));
              },
              child: Text((publication.numberComments>0)?'Ver todo los ${publication.numberComments} comentarios':'Participa en el foro',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.5),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
  final _storage = const FlutterSecureStorage();
  Future<void> deletePost() async {
    final userToken = await _storage.read(key: 'USER_TOKEN');
    CustomAlerts.showConfirmationDialog(postsPageKey.currentContext!).then((value) async => {
      if(value){
        await HttpHeadersGlobal.headerDeleteHttpWithToken(userToken!, '$_endPoint/api/v1/publications/${publication.id}').then((res){
          if(res.statusCode==200){
            CustomAlerts.showSuccessDialog(postsPageKey.currentContext!, "Publicacion eliminada","Publicacion eliminada exitosamente");
          }else{
            CustomAlerts.showErrorDialog(postsPageKey.currentContext!, "Error al eliminar publicacion");
          }
        })
      }
    });
  }
}
