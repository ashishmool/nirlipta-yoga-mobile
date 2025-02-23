import '../../domain/entity/user_entity.dart';

abstract interface class IUserDataSource {
  Future<void> createUser(UserEntity userEntity);

  Future<List<UserEntity>> getAllUsers(String token);

  Future<void> deleteUser(String id);

  Future<void> updateUser(String id, String token);

  Future<List<String>> login(String email, String password);
}
