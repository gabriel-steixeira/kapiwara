import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/item_entity.dart';
import '../repositories/home_repository.dart';

@injectable
class GetItemsUseCase {
  final HomeRepository repository;
  
  GetItemsUseCase(this.repository);
  
  Future<Either<Failure, List<ItemEntity>>> call() async {
    return await repository.getItems();
  }
} 