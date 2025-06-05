import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_name_model.dart';

abstract class NameConfigurationLocalDataSource {
  Future<void> saveName(String name);
  Future<UserNameModel?> getName();
  Future<void> deleteName();
}

@LazySingleton(as: NameConfigurationLocalDataSource)
class NameConfigurationLocalDataSourceImpl implements NameConfigurationLocalDataSource {
  final SharedPreferences sharedPreferences;
  
  static const String _nameKey = 'user_name';
  static const String _updatedAtKey = 'user_name_updated_at';
  
  NameConfigurationLocalDataSourceImpl(this.sharedPreferences);
  
  @override
  Future<void> saveName(String name) async {
    await sharedPreferences.setString(_nameKey, name);
    await sharedPreferences.setString(_updatedAtKey, DateTime.now().toIso8601String());
  }
  
  @override
  Future<UserNameModel?> getName() async {
    final name = sharedPreferences.getString(_nameKey);
    final updatedAtString = sharedPreferences.getString(_updatedAtKey);
    
    if (name == null) return null;
    
    final updatedAt = updatedAtString != null 
        ? DateTime.parse(updatedAtString)
        : DateTime.now();
    
    return UserNameModel(
      name: name,
      updatedAt: updatedAt,
    );
  }
  
  @override
  Future<void> deleteName() async {
    await sharedPreferences.remove(_nameKey);
    await sharedPreferences.remove(_updatedAtKey);
  }
} 