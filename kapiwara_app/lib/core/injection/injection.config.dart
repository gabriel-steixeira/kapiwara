// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:kapiwara_app/core/network/dio_client.dart' as _i812;
import 'package:kapiwara_app/features/home/data/datasources/home_remote_datasource.dart'
    as _i95;
import 'package:kapiwara_app/features/home/data/repositories/home_repository_impl.dart'
    as _i310;
import 'package:kapiwara_app/features/home/domain/repositories/home_repository.dart'
    as _i1001;
import 'package:kapiwara_app/features/home/domain/usecases/get_items_usecase.dart'
    as _i842;
import 'package:kapiwara_app/features/home/presentation/bloc/home_bloc.dart'
    as _i845;
import 'package:kapiwara_app/features/name_configuration/data/datasources/name_configuration_local_datasource.dart'
    as _i766;
import 'package:kapiwara_app/features/name_configuration/data/repositories/name_configuration_repository_impl.dart'
    as _i109;
import 'package:kapiwara_app/features/name_configuration/domain/repositories/name_configuration_repository.dart'
    as _i45;
import 'package:kapiwara_app/features/name_configuration/domain/usecases/get_name_usecase.dart'
    as _i594;
import 'package:kapiwara_app/features/name_configuration/domain/usecases/save_name_usecase.dart'
    as _i21;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i812.DioClient>(() => _i812.DioClient());
    gh.lazySingleton<_i95.HomeRemoteDataSource>(
      () => _i95.HomeRemoteDataSourceImpl(gh<_i812.DioClient>()),
    );
    gh.lazySingleton<_i1001.HomeRepository>(
      () => _i310.HomeRepositoryImpl(gh<_i95.HomeRemoteDataSource>()),
    );
    gh.lazySingleton<_i766.NameConfigurationLocalDataSource>(
      () => _i766.NameConfigurationLocalDataSourceImpl(
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i842.GetItemsUseCase>(
      () => _i842.GetItemsUseCase(gh<_i1001.HomeRepository>()),
    );
    gh.lazySingleton<_i45.NameConfigurationRepository>(
      () => _i109.NameConfigurationRepositoryImpl(
        gh<_i766.NameConfigurationLocalDataSource>(),
      ),
    );
    gh.factory<_i845.HomeBloc>(
      () => _i845.HomeBloc(gh<_i842.GetItemsUseCase>()),
    );
    gh.factory<_i21.SaveNameUseCase>(
      () => _i21.SaveNameUseCase(gh<_i45.NameConfigurationRepository>()),
    );
    gh.factory<_i594.GetNameUseCase>(
      () => _i594.GetNameUseCase(gh<_i45.NameConfigurationRepository>()),
    );
    return this;
  }
}
