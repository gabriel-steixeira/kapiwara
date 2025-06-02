import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/item_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ItemEntity>>> getItems();
  Future<Either<Failure, ItemEntity>> getItemById(int id);
} 