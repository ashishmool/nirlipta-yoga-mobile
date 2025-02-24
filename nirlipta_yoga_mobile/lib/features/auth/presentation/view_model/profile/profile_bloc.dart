import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/shared_prefs/user_shared_prefs.dart';
import '../../../domain/entity/user_entity.dart';
import '../../../domain/use_case/get_user_by_id_usecase.dart';
import '../../../domain/use_case/update_user_usecase.dart';
import '../../../domain/use_case/upload_image_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateUserUsecase _updateUserUsecase;
  final GetUserByIdUsecase _getUserByIdUsecase;
  final UserSharedPrefs _userSharedPrefs;
  final UploadImageUseCase _uploadImageUseCase;

  ProfileBloc({
    required UpdateUserUsecase updateUserUsecase,
    required GetUserByIdUsecase getUserByIdUsecase,
    required UserSharedPrefs userSharedPrefs,
    required UploadImageUseCase uploadImageUseCase,
  })  : _updateUserUsecase = updateUserUsecase,
        _getUserByIdUsecase = getUserByIdUsecase,
        _userSharedPrefs = userSharedPrefs,
        _uploadImageUseCase = uploadImageUseCase,
        super(ProfileState.initial()) {
    on<LoadImage>(_onLoadImage);
    on<FetchUserById>(_onFetchUserById);
    on<UpdateUserProfile>(_onUpdateUserProfile);

    // Fetch userId from shared preferences and load user data
    _fetchAndLoadUserProfile();
  }

  void _onLoadImage(
    LoadImage event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isImageLoading: true));
    final result = await _uploadImageUseCase.call(
      UploadImageParams(
        file: event.file,
      ),
    );

    result.fold(
      (l) => emit(state.copyWith(isImageLoading: false, isImageSuccess: false)),
      (r) {
        emit(state.copyWith(
          isImageLoading: false,
          isImageSuccess: true,
          imageName: r,
        ));
      },
    );
  }

  Future<void> _fetchAndLoadUserProfile() async {
    final userData = await _userSharedPrefs.getUserData();
    final userId = userData.fold(
      (failure) => null,
      (data) => data[2], // userId is at index 2 in the user data
    );

    print("Fetched userId: $userId"); // Debugging

    if (userId != null && userId != "userId") {
      // Ensure it’s not a placeholder
      emit(state.copyWith(userId: userId));
      add(FetchUserById(userId: userId));
    }
  }

  Future<void> _onFetchUserById(
    FetchUserById event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getUserByIdUsecase.call(
      GetUserByIdParams(userId: event.userId),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: failure.message,
        ));
      },
      (user) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          user: user,
        ));
      },
    );
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isUpdateLoading: true));

    final params = UpdateUserParams(
      id: event.id,
      name: event.name,
      username: event.username,
      phone: event.phone,
      email: event.email,
      password: event.password,
      photo: event.photo,
      gender: event.gender,
      medical_conditions: event.medical_conditions,
    );

    final result = await _updateUserUsecase.call(params);

    result.fold(
      (failure) => emit(state.copyWith(
        isUpdateLoading: false,
        isUpdateSuccess: false,
        errorMessage: failure.message,
      )),
      (_) {
        emit(state.copyWith(
          isUpdateLoading: false,
          isUpdateSuccess: true,
        ));

        // Optionally, fetch the updated user data
        add(FetchUserById(userId: event.id));
      },
    );
  }
}
