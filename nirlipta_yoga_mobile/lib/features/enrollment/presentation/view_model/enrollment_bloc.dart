import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/enrollment_entity.dart';
import '../../domain/use_case/create_enrollment_usecase.dart';
import '../../domain/use_case/delete_enrollment_usecase.dart';
import '../../domain/use_case/get_all_enrollments_usecase.dart';

part 'enrollment_event.dart';
part 'enrollment_state.dart';

class EnrollmentBloc extends Bloc<EnrollmentEvent, EnrollmentState> {
  final CreateEnrollmentUseCase _createEnrollmentUseCase;
  final GetAllEnrollmentsUseCase _getAllEnrollmentUseCase;
  final DeleteEnrollmentUseCase _deleteEnrollmentUseCase;

  EnrollmentBloc({
    required CreateEnrollmentUseCase createEnrollmentUseCase,
    required GetAllEnrollmentsUseCase getAllEnrollmentUseCase,
    required DeleteEnrollmentUseCase deleteEnrollmentUseCase,
  })  : _createEnrollmentUseCase = createEnrollmentUseCase,
        _getAllEnrollmentUseCase = getAllEnrollmentUseCase,
        _deleteEnrollmentUseCase = deleteEnrollmentUseCase,
        super(EnrollmentState.initial()) {
    on<LoadEnrollments>(_onLoadEnrollments);
    on<AddEnrollment>(_onAddEnrollment);
    on<DeleteEnrollment>(_onDeleteEnrollment);

    // Should be turned OFF for testing purposes
    // Trigger initial enrollment loading
    add(LoadEnrollments());
  }

  // Future<void> _onLoadEnrollments(
  //     LoadEnrollments event, Emitter<EnrollmentState> emit) async {
  //   // emit(state.copyWith(isLoading: true));
  //   final result = await _getAllEnrollmentUseCase.call();
  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, error: failure.message)),
  //     (enrollments) => emit(state.copyWith(
  //         isLoading: false, error: null, enrollments: enrollments)),
  //   );
  // }

  Future<void> _onLoadEnrollments(
      LoadEnrollments event, Emitter<EnrollmentState> emit) async {
    print("Loading enrollments..."); // Debugging log

    final result = await _getAllEnrollmentUseCase.call();

    result.fold(
      (failure) {
        print("Error loading enrollments: ${failure.message}");
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (enrollments) {
        print("Enrollments fetched: $enrollments");
        emit(state.copyWith(
            isLoading: false, error: null, enrollments: enrollments));
      },
    );
  }

  Future<void> _onAddEnrollment(
      AddEnrollment event, Emitter<EnrollmentState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createEnrollmentUseCase.call(CreateEnrollmentParams(
        userId: event.userId, workshopId: event.workshopId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (enrollments) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadEnrollments());
      },
    );
  }

  Future<void> _onDeleteEnrollment(
      DeleteEnrollment event, Emitter<EnrollmentState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteEnrollmentUseCase
        .call(DeleteEnrollmentParams(id: event.id));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (enrollments) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadEnrollments());
      },
    );
  }
}
