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
      return ['']; // ❌ This should return meaningful data
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateUser(
      String id, String token, Map<String, dynamic> userData) async {
    try {
      await _hiveService.updateUser(id, token, userData);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> receiveOtp(String email) async {
    try {
      String? otp = await _hiveService.receiveOtp(email);

      if (otp == null) {
        throw Exception("User not found or OTP generation failed.");
      }

      return otp;
    } catch (e) {
      throw Exception("Error receiving OTP: ${e.toString()}");
    }
  }

  @override
  Future<void> setNewPassword(
      String email, String newPassword, String otp) async {
    try {
      await _hiveService.setNewPassword(email, newPassword, otp);
    } catch (e) {
      throw Exception(e);
    }
  }
}
