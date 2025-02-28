part of 'enrollment_bloc.dart';

class EnrollmentState extends Equatable {
  final List<EnrollmentEntity> enrollments;
  final bool isLoading;
  final String? error;
  final String? userId;

  const EnrollmentState({
    required this.enrollments,
    required this.isLoading,
    this.error,
    this.userId,
  });

  factory EnrollmentState.initial() {
    return EnrollmentState(
      enrollments: [],
      isLoading: false,
      userId: null,
    );
  }

  EnrollmentState copyWith({
    List<EnrollmentEntity>? enrollments,
    bool? isLoading,
    String? error,
    String? userId,
  }) {
    return EnrollmentState(
      enrollments: enrollments ?? this.enrollments,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [enrollments, isLoading, error, userId];
}
