import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../batch/data/model/batch_hive_model.dart';
import '../../../../batch/presentation/view_model/batch_bloc.dart';
import '../../../../course/data/model/course_hive_model.dart';
import '../../../../course/presentation/view_model/course_bloc.dart';
import '../../../domain/use_case/create_student_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final BatchBloc _batchBloc;
  final CourseBloc _courseBloc;
  final CreateStudentUsecase _createStudentUsecase;

  RegisterBloc({
    required BatchBloc batchBloc,
    required CourseBloc courseBloc,
    required CreateStudentUsecase createStudentUsecase,
  })  : _batchBloc = batchBloc,
        _courseBloc = courseBloc,
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
    _courseBloc.add(LoadCourses());
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  Future<void> _onRegisterStudent(
      RegisterStudent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));

    final params = CreateStudentParams(
      fName: event.fName,
      lName: event.lName,
      phone: event.phone,
      email: event.email,
      password: event.password,
      batch: event.batch,
      courses: event.courses,
    );

    final result = await _createStudentUsecase.call(params);

    result.fold(
        (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (student) => emit(state.copyWith(isLoading: false, isSuccess: true)));
  }
}
