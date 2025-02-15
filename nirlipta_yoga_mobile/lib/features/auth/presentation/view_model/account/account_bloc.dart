import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/user_entity.dart';
import '../../../domain/use_case/get_user_by_id_usecase.dart';
import '../../../domain/use_case/update_user_usecase.dart';
import '../../../domain/use_case/upload_image_usecase.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetUserByIdUsecase _getUserUsecase;
  final UpdateUserUsecase _updateUserUsecase;
  final UploadImageUseCase _uploadImageUseCase;

  AccountBloc({
    required GetUserByIdUsecase getUserUsecase,
    required UpdateUserUsecase updateUserUsecase,
    required UploadImageUseCase uploadImageUseCase,
  })  : _getUserUsecase = getUserUsecase,
        _updateUserUsecase = updateUserUsecase,
        _uploadImageUseCase = uploadImageUseCase,
        super(AccountState.initial()) {
    on<FetchUserDetails>(_onFetchUserDetails);
    on<UpdateUserDetails>(_onUpdateUserDetails);
    on<UploadProfileImage>(_onUploadProfileImage);
  }

  Future<void> _onFetchUserDetails(
    FetchUserDetails event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getUserUsecase.call(GetUserByIdParams(
        id: '67a9bc8608b32dce76f212ed')); // Need to Pass the correct user ID

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (user) => emit(state.copyWith(isLoading: false, user: user)),
    );
  }

  Future<void> _onUpdateUserDetails(
    UpdateUserDetails event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _updateUserUsecase.call(event.params);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (_) {
        // Create a UserEntity from UpdateUserParams and update the state
        final updatedUser = UserEntity(
          id: event.params.id,
          name: event.params.name,
          username: event.params.username,
          phone: event.params.phone,
          email: event.params.email,
          password: event.params.password,
          photo: event.params.photo,
          gender: event.params.gender,
          medical_conditions: event.params.medical_conditions,
          // Add any other fields needed (e.g., dob, if it's available)
        );

        emit(state.copyWith(
            isLoading: false,
            user: updatedUser)); // Updated user info after success
      },
    );
  }

  Future<void> _onUploadProfileImage(
    UploadProfileImage event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(isImageLoading: true));
    final result = await _uploadImageUseCase.call(
      UploadImageParams(file: event.file),
    );

    result.fold(
      (failure) => emit(
          state.copyWith(isImageLoading: false, errorMessage: failure.message)),
      (imageName) =>
          emit(state.copyWith(isImageLoading: false, imageName: imageName)),
    );
  }
}
