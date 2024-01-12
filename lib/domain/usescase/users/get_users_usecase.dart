


import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/usecases.dart';
import '../../entity/user_entity.dart';
import '../../repository/user_repository.dart';

class GetUsersUseCase extends FutureUsesCase<List<UserEntity>, NoParams> {
  GetUsersUseCase({
    required this.userRepository,
  });

  final UserRepository userRepository;
  @override
  Future<Either<UserFailure, List<UserEntity>>> call(NoParams params)   {
    return userRepository.getUsers();
  }
}