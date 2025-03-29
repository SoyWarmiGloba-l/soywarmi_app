import 'package:dartz/dartz.dart';
import 'package:soywarmi_app/core/failures.dart';
import 'package:soywarmi_app/core/usecases.dart';
import 'package:soywarmi_app/domain/entity/publications_entity.dart';
import 'package:soywarmi_app/domain/repository/publications_repository.dart';

class GetPublicatiosUseCase
    extends FutureUsesCase<List<PublicationEntity>, NoParams> {
  GetPublicatiosUseCase({required this.publicationsRepository});

  final PublicationsRepository publicationsRepository;
  @override
  Future<Either<PublicationsFailure, List<PublicationEntity>>> call(NoParams params) {
    return publicationsRepository.getRecentPublications();
  }
}
