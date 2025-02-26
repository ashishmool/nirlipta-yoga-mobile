import '../../../../../core/network/hive_service.dart';
import '../../../domain/entity/user_entity.dart';
import '../../model/user_hive_model.dart';
import '../user_data_source.dart';

class UserLocalDatasource implements IUserDataSource {
  final HiveService _hiveService;

  UserLocalDatasource(this._hiveService);

  @override
  Future<void> createUser(userEntity) async {
    try {
      final userHiveModel = UserHiveModel.fromEntity(userEntity);
      await _hiveService.addUser(userHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      return await _hiveService.deleteUser(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<UserEntity>> getAllUsers(String token) async {
    try {
      return await _hiveService.getAllUsers().then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<String>> login(String email, String password) async {
    try {
      final userHiveModel = await _hiveService.loginUser(email, password);
      return [''];
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateUser(String id, String token) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<String> receiveOtp(String email) {
    // TODO: implement receiveOtp
    throw UnimplementedError();
  }

  @override
  Future<void> setNewPassword(String email, String newPassword, String otp) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
