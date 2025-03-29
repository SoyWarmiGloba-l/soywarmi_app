import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pusher_client_fixed/pusher_client_fixed.dart';
import 'package:soywarmi_app/core/inyection_container.dart';
import 'package:soywarmi_app/domain/entity/publications_entity.dart';
import 'package:soywarmi_app/presentation/bloc/publications/get_publications_cubit.dart';
import 'package:soywarmi_app/presentation/bloc/publications/get_publications_state.dart';
import 'package:soywarmi_app/presentation/widget/card_post_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../core/language/locales.dart';
import '../widget/custom_text_field.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pusher = PusherClient(
      'app-key',
      PusherOptions(
        host: '${dotenv.env["SOCKET_ENDPOINT"]}',
        wssPort: 443,
        wsPort: 80, // port is 6001 by default
        encrypted: true, // true for use SSL
      ),
      autoConnect: false,
      enableLogging: true,
    );
    obtainMyAccount();
    unsuscribePublications().then((value) => {connect()});
  }

  final storage = const FlutterSecureStorage();
  Map<dynamic, dynamic> myAccount = {"name": ""};
  Future<void> obtainMyAccount() async {
    final myAccountJson = await storage.read(key: 'my_account');
    if (myAccountJson != null) {
      setState(() {
        myAccount = jsonDecode(myAccountJson);
      });
    }
  }

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  Future<void> unsuscribePublications() async {
    pusher.unsubscribe("publicaciones");
  }

  late PusherClient pusher;
  int numeroPublicacionesNuevas = 0;
  int numeroPublicaciones = 0;
  connect() async {
    Channel channel3 = pusher.subscribe("publicaciones");
    channel3.bind("registro-publicacion", (PusherEvent? event) {
      print(
          "-------------------------------------------------------------------------------------------------------------");
      String? data = event?.data;
      if (data != null) {
        String dataNN = data!;
        dynamic dataJson = jsonDecode(dataNN);
        int numeroPublicacionesActuales =
            int.parse(dataJson["numeroPublicaciones"]);
        numeroPublicacionesNuevas =
            numeroPublicacionesActuales - numeroPublicaciones;
        _counter.value = numeroPublicacionesNuevas;
      }
    });
    channel3.bind("cambio-publicaciones", (PusherEvent? event) {
      sl<GetPublicationsCubit>().getPublications();
    });
  }

  final GlobalKey<_PostsPageState> postsPageKey = GlobalKey();
  final TextEditingController _searchController = TextEditingController();

  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: postsPageKey,
      backgroundColor: Colors.white,
      color: Theme.of(context).primaryColor,
      onRefresh: () async {
        _counter.value = 0;
        sl<GetPublicationsCubit>().getPublications();
      },
      child: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 2),
            child: CustomTextField(
              controller: _searchController,
              label: LocaleData.buscarPublicacion.getString(context),
              colored: true,
              onChanged: (_) {
                setState(() {
                  _filterPublications();
                });
              },
            ),
          ),
          ValueListenableBuilder<int>(
            builder: (BuildContext context, int value, Widget? child) {
              return (value > 0)
                  ? Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: Colors.blueGrey),
                        child: Text(
                          'Numero de publicaciones nuevas $value',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : const SizedBox();
            },
            valueListenable: _counter,
          ),
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: BlocBuilder<GetPublicationsCubit, GetPublicationsState>(
                bloc: sl<GetPublicationsCubit>()..getPublications(),
                builder: (context, state) {
                  if (state is GetPublicationsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              'No se pudo cargar las publicaciones, intente de nuevo'),
                          IconButton(
                            onPressed: () {
                              sl<GetPublicationsCubit>().getPublications();
                            },
                            icon: Icon(Icons.refresh,
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    );
                  }

                  if (state is GetPublicationsLoaded) {
                    final publications=state.publications;
                    print(publications);
                    numeroPublicaciones = state.publications.length;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _filteredPublications.isNotEmpty
                          ? _filteredPublications.length
                          : publications.length,
                      itemBuilder: (context, index) {
                        final publication = _filteredPublications.isNotEmpty
                            ? _filteredPublications[index]
                            : publications[index];
                        return CardPostPage(
                            idUser: myAccount["id"].toString(),
                            publication: publication,
                            postsPageKey: postsPageKey);
                      },
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  List<PublicationEntity> _filteredPublications = [];
  void _filterPublications() {
    final searchQuery = _searchController.text.toLowerCase();
    setState(() {
      _filteredPublications = [];

      final publications = sl<GetPublicationsCubit>().state.publications;

      _filteredPublications.addAll(publications!.where((publication) {
        return publication.title.toLowerCase().contains(searchQuery);
      }));
    });
  }
}
