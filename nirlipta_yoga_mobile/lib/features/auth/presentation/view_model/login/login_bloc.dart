import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/snackbar/snackbar.dart';
import '../../../../home/presentation/view_model/home_cubit.dart';
import '../../../domain/use_case/login_user_usecase.dart';
import '../signup/register_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;

  // final BatchBloc _batchBloc;
  // final WorkshopBloc _workshopBloc;
  final LoginUserUsecase _loginUserUsecase;

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
    // required BatchBloc batchBloc,
    // required WorkshopBloc workshopBloc,
    required LoginUserUsecase loginUserUsecase,
  })  : _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        // _batchBloc = batchBloc,
        // _workshopBloc = workshopBloc,
        _loginUserUsecase = loginUserUsecase,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _registerBloc),
              // BlocProvider.value(value: _batchBloc),
              // BlocProvider.value(value: _workshopBloc),
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
    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final params = LoginUserParams(
        email: event.email,
        password: event.password,
      );

      final result = await _loginUserUsecase.call(params);

      result.fold(
        (failure) {
          // If the failure has a message, use it; otherwise, use a fallback
          String errorMessage = failure.message;

          // Handle failure (update the state with error message or show a failure alert)
          emit(state.copyWith(isLoading: false, isSuccess: false));

          showMySnackBar(
            context: event.context,
            // message: errorMessage,
            message: 'Invalid Credentials: $errorMessage',
            color: Color(0xFF9B6763),
          );
        },
        (user) {
          // On success, update state and navigate to the home screen
          emit(state.copyWith(isLoading: false, isSuccess: true));

          // Trigger navigation
          add(
            NavigateHomeScreenEvent(
              context: event.context,
              destination: event.destination,
            ),
          );
        },
      );
    });
  }
}
