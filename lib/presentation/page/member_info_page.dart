import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soywarmi_app/domain/entity/member_entity.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'main_page.dart';

class MemberInfoPage extends StatefulWidget {
  final MemberEntity member;
  const MemberInfoPage({required this.member, super.key});

  @override
  State<MemberInfoPage> createState() => _MemberInfoPageState();
}

class _MemberInfoPageState extends State<MemberInfoPage> {
  final endPoint = dotenv.env['API_ENDPOINT'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: NbSecondSecondaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            decoration: const BoxDecoration(color: NbSecondSecondaryColor),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage((widget.member.photo!="")?'$endPoint${widget.member.photo}':"$endPoint/storage/default_image.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.member.name,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(Icons.phone),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 10),*/
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: IconButton(
                        icon: const Icon(
                          Icons.message,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(selectedIndex: 4)));
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
                    child: Column(children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Informacion',
                            style: TextStyle(fontSize: 18),
                          )),
                      const SizedBox(height: 10),
                      Text(
                        widget.member.description,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 10),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Ubicacion',
                            style: TextStyle(fontSize: 18),
                          )),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: NbSecondSecondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Cochabamba',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Contacto',
                            style: TextStyle(fontSize: 18),
                          )),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: NbSecondSecondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.member.phone.toString(),
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: NbSecondSecondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.member.email,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Rol en la comunidad',
                            style: TextStyle(fontSize: 18),
                          )),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: NbSecondSecondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.member.role.isEmpty
                                      ? 'Miembro'
                                      : widget.member.role,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Genero',
                            style: TextStyle(fontSize: 18),
                          )),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: NbSecondSecondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.member.gender.isEmpty
                                      ? ''
                                      : widget.member.gender,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*const SizedBox(height: 10),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Redes sociales',
                            style: TextStyle(fontSize: 18),
                          )),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: NbSecondSecondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: const Icon(Icons.facebook),
                                  onPressed: () {
                                    //open facebook
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: NbSecondSecondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: const Icon(FontAwesomeIcons.instagram),
                                  onPressed: () {
                                    //open instagram
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: NbSecondSecondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: const Icon(FontAwesomeIcons.twitter),
                                  onPressed: () {
                                    //open twitter

                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),*/
                    ]),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
