import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/get_otp_usecase.dart';

part 'request_otp_event.dart';
part 'request_otp_state.dart';

class RequestOtpBloc extends Bloc<RequestOtpEvent, RequestOtpState> {
  final GetOtpUseCase _getOtpUseCase;

  RequestOtpBloc({required GetOtpUseCase getOtpUseCase})
      : _getOtpUseCase = getOtpUseCase,
        super(const RequestOtpState()) {
    on<RequestOtpSubmitted>((event, emit) async {
      emit(state.copyWith(
          isLoading: true, isSuccess: false, errorMessage: null));

      final params = GetOtpParams(email: event.email);

      final result = await _getOtpUseCase.call(params);

      result.fold(
        (failure) {
          emit(state.copyWith(
            isLoading: false,
            isSuccess: false,
            errorMessage: failure.message, // ✅ Store error message in state
          ));
        },
        (response) {
          emit(state.copyWith(
            isLoading: false,
            isSuccess: true,
            errorMessage: null, // ✅ Clear error on success
          ));
        },
      );
    });
  }
}
