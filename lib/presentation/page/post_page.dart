import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:soywarmi_app/domain/entity/publications_entity.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key, required this.publication});
  final PublicationEntity publication;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(NbImageEmpty),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    //(widget.publication.anonymous)?"Anonimo":widget.publication.email,
                    "Anonimo",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.publication.title,
                    style: TextStyle(
                      fontSize: 16,
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
                CarouselSlider.builder(
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
                ),
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
                            '19',
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Escribe un comentario...',
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
                            onPressed: () {},
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
}
