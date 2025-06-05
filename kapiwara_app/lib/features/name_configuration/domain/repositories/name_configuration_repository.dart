import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_name_entity.dart';

abstract class NameConfigurationRepository {
  Future<Either<Failure, void>> saveName(String name);
  Future<Either<Failure, UserNameEntity?>> getName();
  Future<Either<Failure, void>> deleteName();
} 