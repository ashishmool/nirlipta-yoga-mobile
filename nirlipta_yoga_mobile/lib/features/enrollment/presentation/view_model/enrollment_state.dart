part of 'enrollment_bloc.dart';

//What to show in UI

class EnrollmentState extends Equatable {
  final List<EnrollmentEntity> enrollments;
  final bool isLoading;
  final String? error;

  const EnrollmentState({
    required this.enrollments,
    required this.isLoading,
    this.error,
  });

  factory EnrollmentState.initial() {
    return EnrollmentState(
      enrollments: [],
      isLoading: false,
    );
  }

  EnrollmentState copyWith({
    List<EnrollmentEntity>? enrollments,
    bool? isLoading,
    String? error,
  }) {
    return EnrollmentState(
      enrollments: enrollments ?? this.enrollments,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [enrollments, isLoading, error];
}
