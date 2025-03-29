import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:soywarmi_app/domain/entity/news_entity.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';

import '../../core/language/locales.dart';

class NewsDetailsScreen extends StatelessWidget {
  NewsDetailsScreen({super.key, required this.news});

  final NewsEntity news;
  final _endPoint = dotenv.env['API_ENDPOINT'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: NBColorWhite,
          elevation: 0,
          title: Text(
            LocaleData.detalle.getString(context),
            style: TextStyle(color: NBPrimaryColor),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
        body: SingleChildScrollView(
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Publicacion: ${news.startDate}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Descripcion:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      news.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Categoria:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                        spacing: 8,
                        children: (news.areas.isNotEmpty)?news.areas
                            .map((e) => Container(
                                  margin: const EdgeInsets.only(
                                      right: 8, bottom: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                        color: NBColorWhite,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList():[]),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
