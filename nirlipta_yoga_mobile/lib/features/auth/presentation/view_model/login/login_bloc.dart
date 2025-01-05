import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:nirlipta_yoga_mobile/features/home/presentation/view_model/home_cubit.dart';

import '../../../../../app/di/di.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
  })  : _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>((event, emit) {
      // Handling navigation should happen in the UI layer
    });

    on<NavigateHomeScreenEvent>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<HomeCubit>(), // Ensure correct HomeCubit instance
            child: event.destination,
          ),
        ),
      );
    });
  }
}
