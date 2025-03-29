import 'package:dartz/dartz.dart';
import 'package:soywarmi_app/core/failures.dart';
import 'package:soywarmi_app/domain/entity/publications_entity.dart';

abstract class PublicationsRepository {
  Future<Either<PublicationsFailure, List<PublicationEntity>>> getPublications();
  Future<Either<PublicationsFailure, List<PublicationEntity>>> getRecentPublications();
  Future<Either<PublicationsFailure, PublicationEntity>> getPublication(int id);
  Future<Either<PublicationsFailure, void>> createPublication(PublicationEntity publication);
  Future<Either<PublicationsFailure, void>> updatePublication(PublicationEntity publication); 
  Future<Either<PublicationsFailure, void>> deletePublication(int id);
}
