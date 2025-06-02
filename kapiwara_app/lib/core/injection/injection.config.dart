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
    gh.factory<_i842.GetItemsUseCase>(
      () => _i842.GetItemsUseCase(gh<_i1001.HomeRepository>()),
    );
    gh.factory<_i845.HomeBloc>(
      () => _i845.HomeBloc(gh<_i842.GetItemsUseCase>()),
    );
    return this;
  }
}
