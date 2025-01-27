import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/use_case/create_user_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  // final BatchBloc _batchBloc;
  // final WorkshopBloc _workshopBloc;
  final CreateUserUsecase _createUserUsecase;

  RegisterBloc({
    // required BatchBloc batchBloc,
    // required WorkshopBloc workshopBloc,
    required CreateUserUsecase createUserUsecase,
  })  :
        // _batchBloc = batchBloc,
        // _workshopBloc = workshopBloc,
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
    // _batchBloc.add(LoadBatches());
    // _workshopBloc.add(LoadWorkshops());
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));

    final params = CreateUserParams(
      name: event.name,
      username: event.username,
      phone: event.phone,
      email: event.email,
      password: event.password,
      photo: event.photo,
      gender: event.gender,
      medical_conditions: event.medical_conditions,
    );

    final result = await _createUserUsecase.call(params);

    result.fold(
        (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (user) => emit(state.copyWith(isLoading: false, isSuccess: true)));
  }
}
