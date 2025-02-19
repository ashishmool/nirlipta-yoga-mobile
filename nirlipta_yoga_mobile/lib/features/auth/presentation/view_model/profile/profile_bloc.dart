import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/shared_prefs/user_shared_prefs.dart';
import '../../../domain/entity/user_entity.dart';
import '../../../domain/use_case/get_user_by_id_usecase.dart';
import '../../../domain/use_case/update_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateUserUsecase _updateUserUsecase;
  final GetUserByIdUsecase _getUserByIdUsecase;
  final UserSharedPrefs _userSharedPrefs;

  ProfileBloc({
    required UpdateUserUsecase updateUserUsecase,
    required GetUserByIdUsecase getUserByIdUsecase,
    required UserSharedPrefs userSharedPrefs,
  })  : _updateUserUsecase = updateUserUsecase,
        _getUserByIdUsecase = getUserByIdUsecase,
        _userSharedPrefs = userSharedPrefs,
        super(ProfileState.initial()) {
    on<FetchUserById>(_onFetchUserById);
    on<UpdateUserProfile>(_onUpdateUserProfile);

    // Fetch userId from shared preferences and load user data
    _fetchAndLoadUserProfile();
  }

  // void _fetchAndLoadUserProfile() async {
  //   final userData = await _userSharedPrefs.getUserData();
  //   final userId = userData.fold(
  //     (failure) => null,
  //     (data) => data[2], // Assuming userId is at index 2 in the user data
  //   );
  //
  //   if (userId != null) {
  //     add(FetchUserById(userId: userId));
  //   }
  // }

  void _fetchAndLoadUserProfile() async {
    final userData = await _userSharedPrefs.getUserData();
    final userId = userData.fold(
      (failure) => null,
      (data) => data[2], // Assuming userId is at index 2 in the user data
    );

    print("Fetched userId from SharedPrefs: $userId"); // Debugging line

    if (userId != null) {
      add(FetchUserById(userId: userId));
    }
  }

  // Future<void> _onFetchUserById(
  //   FetchUserById event,
  //   Emitter<ProfileState> emit,
  // ) async {
  //   emit(state.copyWith(isLoading: true));
  //
  //   final result = await _getUserByIdUsecase
  //       .call(GetUserByIdParams(user_id: event.userId));
  //
  //   result.fold(
  //     (failure) => emit(state.copyWith(
  //       isLoading: false,
  //       isSuccess: false,
  //       errorMessage: failure.message,
  //     )),
  //     (user) => emit(state.copyWith(
  //       isLoading: false,
  //       isSuccess: true,
  //       user: user,
  //     )),
  //   );
  // }

  Future<void> _onFetchUserById(
    FetchUserById event,
    Emitter<ProfileState> emit,
  ) async {
    print("Fetching user with ID: ${event.userId}"); // Debugging line
    emit(state.copyWith(isLoading: true));

    final result = await _getUserByIdUsecase
        .call(GetUserByIdParams(user_id: event.userId));

    result.fold(
      (failure) {
        print("Fetch failed: ${failure.message}"); // Debugging line
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: failure.message,
        ));
      },
      (user) {
        print("User fetched successfully: $user"); // Debugging line
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

    final result = await _updateUserUsecase.call(event.params);

    result.fold(
      (failure) => emit(state.copyWith(
        isUpdateLoading: false,
        isUpdateSuccess: false,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        isUpdateLoading: false,
        isUpdateSuccess: true,
      )),
    );
  }
}
