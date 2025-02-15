import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/failure.dart';

class UserSharedPrefs {
  final SharedPreferences _sharedPreferences;

  UserSharedPrefs(this._sharedPreferences);

  // Save user_id
  Future<Either<Failure, void>> saveUserId(String userId) async {
    try {
      await _sharedPreferences.setString('user_id', userId);
      return Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Retrieve user_id
  Future<Either<Failure, String>> getUserId() async {
    try {
      final userId = _sharedPreferences.getString('user_id');
      return Right(userId ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
