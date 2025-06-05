import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_name_entity.dart';
import '../repositories/name_configuration_repository.dart';

@injectable
class GetNameUseCase {
  final NameConfigurationRepository repository;
  
  GetNameUseCase(this.repository);
  
  Future<Either<Failure, UserNameEntity?>> call() async {
    return await repository.getName();
  }
} 