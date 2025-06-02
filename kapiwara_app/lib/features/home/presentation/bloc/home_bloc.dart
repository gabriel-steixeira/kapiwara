import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_items_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetItemsUseCase getItemsUseCase;
  
  HomeBloc(this.getItemsUseCase) : super(const HomeInitial()) {
    on<LoadItemsEvent>(_onLoadItems);
    on<RefreshItemsEvent>(_onRefreshItems);
  }
  
  Future<void> _onLoadItems(LoadItemsEvent event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    
    final result = await getItemsUseCase();
    
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (items) => emit(HomeLoaded(items)),
    );
  }
  
  Future<void> _onRefreshItems(RefreshItemsEvent event, Emitter<HomeState> emit) async {
    // Não mostra loading para refresh
    final result = await getItemsUseCase();
    
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (items) => emit(HomeLoaded(items)),
    );
  }
} 