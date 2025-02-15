part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class FetchUserDetails extends AccountEvent {}

class UpdateUserDetails extends AccountEvent {
  final UpdateUserParams params;

  const UpdateUserDetails({required this.params});

  @override
  List<Object> get props => [params];
}

class UploadProfileImage extends AccountEvent {
  final File file;

  const UploadProfileImage({required this.file});

  @override
  List<Object> get props => [file];
}
