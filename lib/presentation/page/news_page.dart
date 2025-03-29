import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:soywarmi_app/core/inyection_container.dart';
import 'package:soywarmi_app/domain/entity/news_entity.dart';
import 'package:soywarmi_app/presentation/bloc/news/get_news_cubit.dart';
import 'package:soywarmi_app/presentation/bloc/news/get_news_state.dart';
import 'package:soywarmi_app/presentation/page/news_details_screen.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';

import '../../core/language/locales.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NBColorWhite,
        elevation: 0,
        title: Text(LocaleData.noticiasSoyWarmi.getString(context),
            style: const TextStyle(color: NBPrimaryColor)),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: BlocBuilder<GetNewsCubit, GetNewsState>(
        bloc: sl<GetNewsCubit>()..getNews(),
        builder: (context, state) {
          if (state is GetNewsLoaded) {
            return NewsList(newsList: state.news);
          }

          if (state is GetNewsError) {
            return Center(
              child: Column(
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
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final List<NewsEntity> newsList;

  const NewsList({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        return NewsCard(
          news: newsList[index],
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NewsDetailsScreen(news: newsList[index])));
          },
        );
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsEntity news;
  final VoidCallback onPressed;
  final _endPoint = dotenv.env['API_ENDPOINT'];

  NewsCard({super.key, required this.news, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: news.images.isEmpty
                    ? NetworkImage(
                    '$_endPoint/storage/default_image.png')
                    : NetworkImage('$_endPoint${news.images[0]["url"]}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              news.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              news.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  news.startDate,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                TextButton(
                    onPressed: onPressed,
                    child: const Text(
                      'Ver más',
                      style: TextStyle(color: NBPrimaryColor),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
