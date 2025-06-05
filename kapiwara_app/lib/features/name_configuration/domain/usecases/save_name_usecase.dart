import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/name_configuration_repository.dart';

@injectable
class SaveNameUseCase {
  final NameConfigurationRepository repository;
  
  SaveNameUseCase(this.repository);
  
  Future<Either<Failure, void>> call(String name) async {
    if (name.trim().isEmpty) {
      return Left(ValidationFailure('Nome não pode estar vazio'));
    }
    
    return await repository.saveName(name.trim());
  }
} 