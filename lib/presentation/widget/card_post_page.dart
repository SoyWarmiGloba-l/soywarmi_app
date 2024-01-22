import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:soywarmi_app/core/language/locales.dart';
import 'package:soywarmi_app/domain/entity/publications_entity.dart';
import 'package:soywarmi_app/presentation/page/post_page.dart';

import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';

class CardPostPage extends StatelessWidget {
  const CardPostPage({super.key, required this.publication});

  final PublicationEntity publication;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(0),
        child: Column(children: [
          Row(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(NbImageEmpty),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              LocaleData.anonimo.getString(context),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
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
                ))
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              publication.description,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColorDark.withOpacity(0.5),
              ),
            ),
          ),
          CarouselSlider.builder(
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

              return Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Row(
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
                ),
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
                      '19',
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
          Padding(
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
          ),
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
              child: Text('Ver todo los 19 comentarios',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.5),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
