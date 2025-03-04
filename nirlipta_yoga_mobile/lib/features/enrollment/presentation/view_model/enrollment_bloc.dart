import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nirlipta_yoga_mobile/app/shared_prefs/user_shared_prefs.dart';
import 'package:nirlipta_yoga_mobile/features/enrollment/domain/use_case/get_enrollment_by_user_usecase.dart';

import '../../../workshop/domain/entity/workshop_entity.dart';
import '../../domain/entity/enrollment_entity.dart';
import '../../domain/use_case/create_enrollment_usecase.dart';
import '../../domain/use_case/delete_enrollment_usecase.dart';
import '../../domain/use_case/update_enrollment_usecase.dart';

part 'enrollment_event.dart';
part 'enrollment_state.dart';

class EnrollmentBloc extends Bloc<EnrollmentEvent, EnrollmentState> {
  final CreateEnrollmentUseCase _createEnrollmentUseCase;
  final DeleteEnrollmentUseCase _deleteEnrollmentUseCase;
  final GetEnrollmentByUserUseCase _getEnrollmentByUserUseCase;
  final UpdateEnrollmentUseCase _updateEnrollmentUseCase;
  final UserSharedPrefs _userSharedPrefs;

  EnrollmentBloc({
    required CreateEnrollmentUseCase createEnrollmentUseCase,
    required GetEnrollmentByUserUseCase getEnrollmentByUserUseCase,
    required DeleteEnrollmentUseCase deleteEnrollmentUseCase,
    required UpdateEnrollmentUseCase updateEnrollmentUseCase,
    required UserSharedPrefs userSharedPrefs,
  })  : _createEnrollmentUseCase = createEnrollmentUseCase,
        _deleteEnrollmentUseCase = deleteEnrollmentUseCase,
        _getEnrollmentByUserUseCase = getEnrollmentByUserUseCase,
        _updateEnrollmentUseCase = updateEnrollmentUseCase,
        _userSharedPrefs = userSharedPrefs,
        super(EnrollmentState.initial()) {
    on<LoadEnrollments>(_onLoadEnrollments);
    on<LoadEnrollmentByUser>(_onLoadEnrollmentByUser);
    on<AddEnrollment>(_onAddEnrollment);
    on<DeleteEnrollment>(_onDeleteEnrollment);
    on<UpdateEnrollment>(_onUpdateEnrollment);

    add(LoadEnrollments());
    _fetchAndLoadUserEnrollments();
  }

  void _fetchAndLoadUserEnrollments() async {
    final userData = await _userSharedPrefs.getUserData();
    final userId = userData.fold(
      (failure) => null,
      (data) => data[2],
    );

    if (userId != null) {
      emit(state.copyWith(userId: userId));
      add(LoadEnrollmentByUser(userId: userId));
    }
  }

  Future<void> _onLoadEnrollments(
      LoadEnrollments event, Emitter<EnrollmentState> emit) async {
    emit(state.copyWith(isLoading: true));

    final userData = await _userSharedPrefs.getUserData();
    final userId = userData.fold(
      (failure) => null,
      (data) => data[2],
    );

    if (userId == null) {
      emit(state.copyWith(isLoading: false, error: "User ID not found"));
      return;
    }

    final result = await _getEnrollmentByUserUseCase
        .call(GetEnrollmentByUserParams(userId: userId));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (enrollments) {
        emit(state.copyWith(
            isLoading: false, error: null, enrollments: enrollments));
      },
    );
  }

  Future<void> _onLoadEnrollmentByUser(
      LoadEnrollmentByUser event, Emitter<EnrollmentState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getEnrollmentByUserUseCase
        .call(GetEnrollmentByUserParams(userId: event.userId));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (enrollments) {
        emit(state.copyWith(
            isLoading: false, error: null, enrollments: enrollments));
      },
    );
  }

  Future<void> _onAddEnrollment(
      AddEnrollment event, Emitter<EnrollmentState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _createEnrollmentUseCase.call(
      CreateEnrollmentParams(
        userId: event.userId,
        workshop: event.workshop,
        paymentStatus: event.paymentStatus,
        enrollmentDate: event.enrollmentDate,
        completionStatus: event.completionStatus,
        feedback: event.feedback,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (_) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadEnrollments());
      },
    );
  }

  Future<void> _onUpdateEnrollment(
      UpdateEnrollment event, Emitter<EnrollmentState> emit) async {
    emit(state.copyWith(isLoading: true));
  }

  Future<void> _onDeleteEnrollment(
      DeleteEnrollment event, Emitter<EnrollmentState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _deleteEnrollmentUseCase
        .call(DeleteEnrollmentParams(id: event.id));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (_) {
        final updatedEnrollments =
            state.enrollments.where((e) => e.id != event.id).toList();

        emit(state.copyWith(
          isLoading: false,
          error: null,
          enrollments: updatedEnrollments,
        ));

        if (updatedEnrollments.isEmpty) {
          emit(state.copyWith(enrollments: []));
        }
      },
    );
  }
}
