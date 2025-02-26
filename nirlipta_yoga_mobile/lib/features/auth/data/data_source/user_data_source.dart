import '../../domain/entity/user_entity.dart';

abstract interface class IUserDataSource {
  Future<void> createUser(UserEntity userEntity);

  Future<List<UserEntity>> getAllUsers(String token);

  Future<void> deleteUser(String id);

  Future<void> updateUser(
      String id, String token, Map<String, dynamic> userData);

  Future<List<String>> login(String email, String password);

  Future<String> receiveOtp(String email);

  Future<void> setNewPassword(String email, String newPassword, String otp);
}
