import 'package:injectable/injectable.dart';

import '../../../../core/network/dio_client.dart';
import '../models/item_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ItemModel>> getItems();
  Future<ItemModel> getItemById(int id);
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;
  
  HomeRemoteDataSourceImpl(this.dioClient);
  
  @override
  Future<List<ItemModel>> getItems() async {
    try {
      final response = await dioClient.get('/items');
      
      final List<dynamic> data = response.data['data'] ?? [];
      return data.map((json) => ItemModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erro ao buscar itens: $e');
    }
  }
  
  @override
  Future<ItemModel> getItemById(int id) async {
    try {
      final response = await dioClient.get('/items/$id');
      
      return ItemModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Erro ao buscar item: $e');
    }
  }
} 