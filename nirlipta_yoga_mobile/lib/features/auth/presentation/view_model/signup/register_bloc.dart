import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../batch/presentation/view_model/batch_bloc.dart';
import '../../../../workshop/data/model/workshop_hive_model.dart';
import '../../../../workshop/presentation/view_model/workshop_bloc.dart';
import '../../../domain/use_case/create_user_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final BatchBloc _batchBloc;
  final WorkshopBloc _workshopBloc;
  final CreateUserUsecase _createUserUsecase;

  RegisterBloc({
    required BatchBloc batchBloc,
    required WorkshopBloc workshopBloc,
    required CreateUserUsecase createUserUsecase,
  })  : _batchBloc = batchBloc,
        _workshopBloc = workshopBloc,
        _createUserUsecase = createUserUsecase,
        super(RegisterState.initial()) {
    on<LoadCoursesAndBatches>(_onRegisterEvent);
    on<RegisterUser>(_onRegisterUser);

    add(LoadCoursesAndBatches());
  }

  void _onRegisterEvent(
    LoadCoursesAndBatches event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(isLoading: true));
    _batchBloc.add(LoadBatches());
    _workshopBloc.add(LoadWorkshops());
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));

    final params = CreateUserParams(
      name: event.name,
      phone: event.phone,
      email: event.email,
      password: event.password,
      gender: event.gender,
      workshops: event.workshops,
    );

    final result = await _createUserUsecase.call(params);

    result.fold(
        (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (user) => emit(state.copyWith(isLoading: false, isSuccess: true)));
  }
}
