import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_name_entity.dart';
import '../../domain/repositories/name_configuration_repository.dart';
import '../datasources/name_configuration_local_datasource.dart';

@LazySingleton(as: NameConfigurationRepository)
class NameConfigurationRepositoryImpl implements NameConfigurationRepository {
  final NameConfigurationLocalDataSource localDataSource;
  
  NameConfigurationRepositoryImpl(this.localDataSource);
  
  @override
  Future<Either<Failure, void>> saveName(String name) async {
    try {
      await localDataSource.saveName(name);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Erro ao salvar nome: ${e.toString()}'));
    }
  }
  
  @override
  Future<Either<Failure, UserNameEntity?>> getName() async {
    try {
      final userNameModel = await localDataSource.getName();
      return Right(userNameModel);
    } catch (e) {
      return Left(CacheFailure('Erro ao buscar nome: ${e.toString()}'));
    }
  }
  
  @override
  Future<Either<Failure, void>> deleteName() async {
    try {
      await localDataSource.deleteName();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Erro ao deletar nome: ${e.toString()}'));
    }
  }
} 