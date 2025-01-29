import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/use_case/create_user_usecase.dart';
import '../../../domain/use_case/upload_image_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  // final BatchBloc _batchBloc;
  // final WorkshopBloc _workshopBloc;
  final CreateUserUsecase _createUserUsecase;
  final UploadImageUseCase _uploadImageUseCase;

  RegisterBloc({
    // required BatchBloc batchBloc,
    // required WorkshopBloc workshopBloc,
    required CreateUserUsecase createUserUsecase,
    required UploadImageUseCase uploadImageUseCase,
  })  :
        // _batchBloc = batchBloc,
        // _workshopBloc = workshopBloc,
        _createUserUsecase = createUserUsecase,
        _uploadImageUseCase = uploadImageUseCase,
        super(RegisterState.initial()) {
    on<LoadCoursesAndBatches>(_onRegisterEvent);
    on<RegisterUser>(_onRegisterUser);
    on<LoadImage>(_onLoadImage);

    add(LoadCoursesAndBatches());
  }

  void _onLoadImage(
    LoadImage event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isImageLoading: true));
    final result = await _uploadImageUseCase.call(
      UploadImageParams(
        file: event.file,
      ),
    );

    result.fold(
        (l) =>
            emit(state.copyWith(isImageLoading: false, isImageSuccess: false)),
        (r) {
      emit(state.copyWith(
          isImageLoading: false, isImageSuccess: true, imageName: r));
    });
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
      photo: state.imageName,
      gender: event.gender,
      medical_conditions: event.medical_conditions,
    );

    final result = await _createUserUsecase.call(params);

    result.fold(
        (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (user) => emit(state.copyWith(isLoading: false, isSuccess: true)));
  }
}
