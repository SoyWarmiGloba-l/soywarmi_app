import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entity/user_entity.dart';


abstract class UserRepository {
  Future<Either<UserFailure, List<UserEntity>>> getUsers();
}