import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../batch/presentation/view_model/batch_bloc.dart';
import '../../../../workshop/data/model/workshop_hive_model.dart';
import '../../../../workshop/presentation/view_model/workshop_bloc.dart';
import '../../../domain/use_case/create_student_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final BatchBloc _batchBloc;
  final WorkshopBloc _workshopBloc;
  final CreateStudentUsecase _createStudentUsecase;

  RegisterBloc({
    required BatchBloc batchBloc,
    required WorkshopBloc workshopBloc,
    required CreateStudentUsecase createStudentUsecase,
  })  : _batchBloc = batchBloc,
        _workshopBloc = workshopBloc,
        _createStudentUsecase = createStudentUsecase,
        super(RegisterState.initial()) {
    on<LoadCoursesAndBatches>(_onRegisterEvent);
    on<RegisterStudent>(_onRegisterStudent);

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

  Future<void> _onRegisterStudent(
      RegisterStudent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));

    final params = CreateStudentParams(
      name: event.name,
      phone: event.phone,
      email: event.email,
      password: event.password,
      gender: event.gender,
      workshops: event.workshops,
    );

    final result = await _createStudentUsecase.call(params);

    result.fold(
        (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (student) => emit(state.copyWith(isLoading: false, isSuccess: true)));
  }
}
