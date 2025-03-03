import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entity/workshop_entity.dart';
import '../../domain/use_case/create_workshop_usecase.dart';
import '../../domain/use_case/delete_workshop_usecase.dart';
import '../../domain/use_case/get_all_workshops_usecase.dart';

part 'workshop_event.dart';
part 'workshop_state.dart';

class WorkshopBloc extends Bloc<WorkshopEvent, WorkshopState> {
  final CreateWorkshopUseCase _createWorkshopUseCase;
  final GetAllWorkshopsUseCase _getAllWorkshopsUseCase;
  final DeleteWorkshopUseCase _deleteWorkshopUseCase;

  WorkshopBloc({
    required CreateWorkshopUseCase createWorkshopUseCase,
    required GetAllWorkshopsUseCase getAllWorkshopsUseCase,
    required DeleteWorkshopUseCase deleteWorkshopUseCase,
  })  : _createWorkshopUseCase = createWorkshopUseCase,
        _getAllWorkshopsUseCase = getAllWorkshopsUseCase,
        _deleteWorkshopUseCase = deleteWorkshopUseCase,
        super(WorkshopState.initial()) {
    on<LoadWorkshops>(_onLoadWorkshops);
    on<AddWorkshop>(_onAddWorkshop);
    on<DeleteWorkshop>(_onDeleteWorkshop);

    // // Comment for Bloc testing
    // Trigger initial loading
    add(LoadWorkshops());
  }

  Future<void> _onLoadWorkshops(
      LoadWorkshops event, Emitter<WorkshopState> emit) async {
    emit(state.copyWith(isLoading: true, workshops: []));
    final result = await _getAllWorkshopsUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (workshops) => emit(state.copyWith(
        isLoading: false,
        error: null,
        workshops: workshops,
      )),
    );
  }

  Future<void> _onAddWorkshop(
      AddWorkshop event, Emitter<WorkshopState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createWorkshopUseCase.call(
      CreateWorkshopParams(
          title: event.title,
          price: event.price,
          difficultyLevel: event.difficultyLevel,
          categoryId: event.categoryId),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => add(LoadWorkshops()),
    );
  }

  Future<void> _onDeleteWorkshop(
      DeleteWorkshop event, Emitter<WorkshopState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteWorkshopUseCase.call(
      DeleteWorkshopParams(workshopId: event.workshopId),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => add(LoadWorkshops()),
    );
  }
}
