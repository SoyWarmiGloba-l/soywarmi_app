import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soywarmi_app/core/inyection_container.dart';
import 'package:soywarmi_app/core/language/locales.dart';
import 'package:soywarmi_app/presentation/bloc/activity/get_activity_cubit.dart';
import 'package:soywarmi_app/presentation/bloc/activity/get_activity_state.dart';
import 'package:soywarmi_app/presentation/bloc/news/get_news_cubit.dart';
import 'package:soywarmi_app/presentation/bloc/news/get_news_state.dart';
import 'package:soywarmi_app/presentation/bloc/team/get_teams_cubit.dart';
import 'package:soywarmi_app/presentation/bloc/team/get_teams_state.dart';
import 'package:soywarmi_app/presentation/page/member_info_page.dart';
import 'package:soywarmi_app/presentation/page/news_details_screen.dart';
import 'package:soywarmi_app/presentation/widget/custom_text_litle.dart';
import 'package:soywarmi_app/presentation/widget/image_container.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _endPoint = dotenv.env['API_ENDPOINT'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtainMyAccount();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: Text(
                '${LocaleData.hola.getString(context)}, ${myAccount["name"]}!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 8),
              child: Text(
                '¿Que tienes planeado para hoy?',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Row(
              children: [
                CustomTextTitle(
                    label: LocaleData.noticiasSoyWarmi.getString(context)),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/news');
                  },
                  child:  Text(
                    LocaleData.verTodo.getString(context),
                    style: const TextStyle(
                      fontSize: 12,
                      color: NBSecondPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: SizedBox(
              height: 200,
              child: BlocBuilder<GetNewsCubit, GetNewsState>(
                bloc: sl<GetNewsCubit>()..getNews(),
                builder: (context, state) {
                  if (state is GetNewsLoaded) {
                    final news = state.news;
                    final numberNewsToShow=(news.length>10)?10:news.length;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: numberNewsToShow,
                      itemBuilder: (context, index) {
                        final newData = news[index];
                        return Container(
                          width: 220,
                          margin: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewsDetailsScreen(news: newData)));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageContainer(
                                  width:
                                      220,
                                  imageUrl: (newData.images.isNotEmpty)?'$_endPoint${newData.images[0]["url"]}':'$_endPoint/storage/default_image.png',
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  newData.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          height: 1.5),
                                ),
                                const SizedBox(height: 5),
                                Text('Publicado ${DateFormat('dd-MM-yyyy HH:mm').format(newData.createdAt)}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                const SizedBox(height: 5),
                                Text('by SoyWarmi',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  if (state is GetNewsError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            'No se pudo cargar las noticias, intente de nuevo'),
                        IconButton(
                          onPressed: () {
                            sl<GetNewsCubit>().getNews();
                          },
                          icon: Icon(Icons.refresh,
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Row(
              children: [
                CustomTextTitle(label: LocaleData.miembros.getString(context)),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/members');
                  },
                  child:  Text(
                    LocaleData.verTodo.getString(context),
                    style: const TextStyle(
                      fontSize: 12,
                      color: NBSecondPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: SizedBox(
                height: 220,
                child: BlocBuilder<GetTeamsCubit, GetTeamsState>(
                  bloc: sl<GetTeamsCubit>()..getTeams(),
                  builder: (context, state) {
                    if (state is GetTeamsError) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              'No se pudo cargar los miembros, intente de nuevo'),
                          IconButton(
                            onPressed: () {
                              sl<GetTeamsCubit>().getTeams();
                            },
                            icon: Icon(Icons.refresh,
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      );
                    }
                    if (state is GetTeamsLoaded) {
                      final members = state.members;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: members.length > 10 ? 10 : members.length,
                        itemBuilder: (context, index) {
                          final member = members[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: NbSecondSecondaryColor,
                            ),
                            width: MediaQuery.of(context).size.width * 0.45,
                            margin: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MemberInfoPage(member: member)));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage((member.photo=='')?'$_endPoint/storage/default_image.png':'$_endPoint${member.photo}')
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    member.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            height: 1.5),
                                  ),
                                  /*const SizedBox(height: 5),
                                  Text('Voluntaria',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),*/
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Row(
              children: [
                const CustomTextTitle(label: 'Actividades'),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/activity');
                  },
                  child:  Text(
                    LocaleData.verTodo.getString(context),
                    style: const TextStyle(
                      fontSize: 12,
                      color: NBSecondPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: SizedBox(
              height: 220,
              child: BlocBuilder<GetActivityCubit, GetActivityState>(
                bloc: sl<GetActivityCubit>()..getActivity(),
                builder: (context, state) {
                  if (state is GetActivityLoaded) {
                    final activity = state.activity;
                    final numberActivitiesToShow=(activity.length>10)?10:activity.length;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: numberActivitiesToShow,
                      itemBuilder: (context, index) {
                        final activityData = activity[index];
                        return Container(
                          width: 220,
                          margin: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //carrusel
                                ImageContainer(
                                  width:220,
                                  imageUrl: activityData.images.isEmpty
                                      ? '$_endPoint/storage/default_image.png'
                                      : '$_endPoint${activityData.images[0]['url']}',
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  activityData.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          height: 1.5),
                                ),
                                const SizedBox(height: 5),
                                Text('Publicado ${DateFormat('dd-MM-yyyy HH:mm').format(activityData.createdAt)}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  if (state is GetNewsError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            'No se pudo cargar las actividades, intente de nuevo'),
                        IconButton(
                          onPressed: () {
                            sl<GetActivityCubit>().getActivity();
                          },
                          icon: Icon(Icons.refresh,
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  final storage = const FlutterSecureStorage();
  Map myAccount={
    "name":""
  };
  Future<void> obtainMyAccount() async {
    final myAccountJson = await storage.read(key: 'my_account');
    if (myAccountJson != null) {
      setState(() {
        myAccount = json.decode(myAccountJson);
      });
    }
  }
}
