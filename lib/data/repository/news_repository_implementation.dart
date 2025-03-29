
import 'package:dartz/dartz.dart';
import 'package:soywarmi_app/core/failures.dart';
import 'package:soywarmi_app/data/remote/news_remote_data_source.dart';
import 'package:soywarmi_app/domain/entity/news_entity.dart';
import 'package:soywarmi_app/domain/repository/news_repository.dart';

class NewsRepositoryImplementation extends NewsRepository {

  NewsRepositoryImplementation({
    required this.newsRemoteDataSource,
  });


  final NewsRemoteDataSource newsRemoteDataSource;
  @override
  Future<Either<NewsFailure, List<NewsEntity>>> getNews() async {
    try {
      final newsModel = await newsRemoteDataSource.getNews();

      final newsEntity = newsModel.map((e) {
        return NewsEntity(
          id: e.id,
          title: e.title,
          description: e.description,
          images: e.images,
          startDate: e.startDate,
          endDate: e.endDate,
          areas: e.areas,
          eventTypes: e.eventTypes.map((e) => EventTypeEntity(
            id: e.id,
            name: e.title,
            description: e.description,
            createdAt: e.createdAt,
            updatedAt: e.updatedAt,
            deletedAt: e.deletedAt
          )).toList(),
          eventTypeId: e.eventTypeId,
          createdAt: e.createdAt,
          updatedAt: e.updatedAt,
          deletedAt: e.deletedAt
        );
      });

      return Right(newsEntity.toList());
      
    } on Exception{
      return Left(NewsFailure('Error al obtener las noticias'));

      
    }
  }
  
}