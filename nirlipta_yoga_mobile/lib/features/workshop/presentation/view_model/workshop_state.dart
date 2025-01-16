part of 'workshop_bloc.dart';

class WorkshopState extends Equatable {
  final List<WorkshopEntity> workshops;
  final bool isLoading;
  final String? error;

  const WorkshopState({
    required this.workshops,
    required this.isLoading,
    this.error,
  });

  factory WorkshopState.initial() {
    return WorkshopState(
      workshops: [],
      isLoading: false,
    );
  }

  WorkshopState copyWith({
    List<WorkshopEntity>? workshops,
    bool? isLoading,
    String? error,
  }) {
    return WorkshopState(
      workshops: workshops ?? this.workshops,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [workshops, isLoading, error];
}
