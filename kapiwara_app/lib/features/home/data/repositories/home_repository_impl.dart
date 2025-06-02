import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/item_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  
  HomeRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<Either<Failure, List<ItemEntity>>> getItems() async {
    try {
      final items = await remoteDataSource.getItems();
      return Right(items);
    } catch (e) {
      return Left(ServerFailure('Erro ao buscar itens: ${e.toString()}'));
    }
  }
  
  @override
  Future<Either<Failure, ItemEntity>> getItemById(int id) async {
    try {
      final item = await remoteDataSource.getItemById(id);
      return Right(item);
    } catch (e) {
      return Left(ServerFailure('Erro ao buscar item: ${e.toString()}'));
    }
  }
} 