import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/course_entity.dart';
import '../../domain/use_case/create_course_usecase.dart';
import '../../domain/use_case/delete_course_usecase.dart';
import '../../domain/use_case/get_all_course_usecase.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CreateCourseUseCase _createCourseUseCase;
  final GetAllCourseUseCase _getAllCourseUseCase;
  final DeleteCourseUseCase _deleteCourseUseCase;

  CourseBloc({
    required CreateCourseUseCase createCourseUseCase,
    required GetAllCourseUseCase getAllCourseUseCase,
    required DeleteCourseUseCase deleteCourseUseCase,
  })  : _createCourseUseCase = createCourseUseCase,
        _getAllCourseUseCase = getAllCourseUseCase,
        _deleteCourseUseCase = deleteCourseUseCase,
        super(CourseState.initial()) {
    on<LoadCourses>(_onLoadCourses);
    on<AddCourse>(_onAddCourse);
    on<DeleteCourse>(_onDeleteCourse);

    // Trigger initial courses loading
    add(LoadCourses());
  }

  Future<void> _onLoadCourses(
      LoadCourses event, Emitter<CourseState> emit) async {
    // fetch courses from a repository
    // // let's just simulate loading with a delay
    // await Future.delayed(const Duration(seconds: 2));
    final result = await _getAllCourseUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (courses) =>
          emit(state.copyWith(isLoading: false, error: null, courses: courses)),
    );
  }

  Future<void> _onAddCourse(AddCourse event, Emitter<CourseState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createCourseUseCase
        .call(CreateCourseParams(courseName: event.courseName));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadCourses());
      },
    );
  }

  Future<void> _onDeleteCourse(
      DeleteCourse event, Emitter<CourseState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteCourseUseCase
        .call(DeleteCourseParams(courseId: event.courseId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadCourses());
      },
    );
  }
}
