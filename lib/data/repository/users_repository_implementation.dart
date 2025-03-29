import 'package:dartz/dartz.dart';
import 'package:soywarmi_app/domain/repository/user_repository.dart';

import '../../core/failures.dart';
import '../../domain/entity/user_entity.dart';
import '../remote/user_remote_data_source.dart';

class UsersRepositoryImplementation extends UserRepository {
  UsersRepositoryImplementation({
    required this.userRemoteDataSource,
  });

  final UserRemoteDataSource userRemoteDataSource;

  @override
  Future<Either<UserFailure, List<UserEntity>>> getUsers() async {
    try {
      final userModel = await userRemoteDataSource.getUsers();

      final listUsers =
          userModel.map((e) => UserEntity(id: e.id, email: e.email, lastname: e.lastname, name: e.name)).toList();

      return Right(listUsers);
    } on Exception {
      return Left(UserFailure('Error al obtener los usuarios'));
    }
  }
}
