import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../batch/presentation/view_model/batch_bloc.dart';
import '../../../../home/presentation/view_model/home_cubit.dart';
import '../../../../workshop/presentation/view_model/workshop_bloc.dart';
import '../../../domain/use_case/login_student_usecase.dart';
import '../signup/register_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;
  final BatchBloc _batchBloc;
  final WorkshopBloc _workshopBloc;
  final LoginStudentUsecase _loginStudentUsecase;

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
    required BatchBloc batchBloc,
    required WorkshopBloc workshopBloc,
    required LoginStudentUsecase loginStudentUsecase,
  })  : _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        _batchBloc = batchBloc,
        _workshopBloc = workshopBloc,
        _loginStudentUsecase = loginStudentUsecase,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _registerBloc),
              BlocProvider.value(value: _batchBloc),
              BlocProvider.value(value: _workshopBloc),
            ],
            child: event.destination,
          ),
        ),
      );
    });

    on<NavigateHomeScreenEvent>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _homeCubit,
            child: event.destination,
          ),
        ),
      );
    });

    // Toggle password visibitlity
    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
    });

    // Handle login event
    on<LoginStudentEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final params = LoginStudentParams(
        email: event.email,
        password: event.password,
      );

      final result = await _loginStudentUsecase.call(params);

      result.fold(
        (failure) {
          // Handle failure (update the state with error message or show a failure alert)
          emit(state.copyWith(isLoading: false, isSuccess: false));
        },
        (student) {
          // On success, update state and navigate to the home screen
          emit(state.copyWith(isLoading: false, isSuccess: true));
        },
      );
    });
  }
}
