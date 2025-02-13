import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/domain/use_case/get_enrollment_by_user_usecase.dart';

import '../../domain/entity/enrollment_entity.dart';
import '../../domain/use_case/create_enrollment_usecase.dart';
import '../../domain/use_case/delete_enrollment_usecase.dart';

part 'enrollment_event.dart';
part 'enrollment_state.dart';

class EnrollmentBloc extends Bloc<EnrollmentEvent, EnrollmentState> {
  final CreateEnrollmentUseCase _createEnrollmentUseCase;
  final DeleteEnrollmentUseCase _deleteEnrollmentUseCase;
  final GetEnrollmentByUserUseCase _getEnrollmentByUserUseCase;
  final String userId;

  EnrollmentBloc({
    required CreateEnrollmentUseCase createEnrollmentUseCase,
    required GetEnrollmentByUserUseCase getEnrollmentByUserUseCase,
    required DeleteEnrollmentUseCase deleteEnrollmentUseCase,
    required this.userId,
  })  : _createEnrollmentUseCase = createEnrollmentUseCase,
        _deleteEnrollmentUseCase = deleteEnrollmentUseCase,
        _getEnrollmentByUserUseCase = getEnrollmentByUserUseCase,
        super(EnrollmentState.initial()) {
    on<LoadEnrollments>(_onLoadEnrollments);
    on<LoadEnrollmentByUser>(_onLoadEnrollmentByUser);
    on<AddEnrollment>(_onAddEnrollment);
    on<DeleteEnrollment>(_onDeleteEnrollment);

    add(LoadEnrollmentByUser(userId: userId));
  }

  Future<void> _onLoadEnrollments(
      LoadEnrollments event, Emitter<EnrollmentState> emit) async {
    print("Loading all enrollments...");
    emit(state.copyWith(isLoading: true));

    final result = await _getEnrollmentByUserUseCase
        .call(GetEnrollmentByUserParams(userId: "some_default_user"));

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

  Future<void> _onLoadEnrollmentByUser(
      LoadEnrollmentByUser event, Emitter<EnrollmentState> emit) async {
    print("Loading enrollments for user: ${event.userId}");
    emit(state.copyWith(isLoading: true));

    final result = await _getEnrollmentByUserUseCase
        .call(GetEnrollmentByUserParams(userId: event.userId));

    result.fold(
      (failure) {
        print("Error loading user enrollments: ${failure.message}");
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (enrollments) {
        print("User enrollments fetched: $enrollments");
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
