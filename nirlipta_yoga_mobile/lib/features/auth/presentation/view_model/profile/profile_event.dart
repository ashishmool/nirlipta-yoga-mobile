part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserById extends ProfileEvent {
  final String userId;

  const FetchUserById({required this.userId});

  @override
  List<Object> get props => [userId];
}

class UpdateUserProfile extends ProfileEvent {
  final UpdateUserParams params;

  const UpdateUserProfile({required this.params});

  @override
  List<Object> get props => [params];
}
