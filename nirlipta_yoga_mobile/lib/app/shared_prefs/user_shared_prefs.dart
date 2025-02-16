import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/failure.dart';

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;

  // Set User Details
  Future<Either<Failure, bool>> setUserData(List<String> data) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      await _sharedPreferences.setString('success', data[0]);
      await _sharedPreferences.setString('token', data[1]);
      await _sharedPreferences.setString('user_id', data[2]);
      await _sharedPreferences.setString('photo', data[3]);
      await _sharedPreferences.setString('email', data[4]);
      await _sharedPreferences.setString('role', data[5]);
      await _sharedPreferences.setString('message', data[6]);
      await _sharedPreferences.setString('statusCode', data[6]);
      return Right(true);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Get User Data
  Future<Either<Failure, List<String?>>> getUserData() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final success = _sharedPreferences.getString('success');
      final token = _sharedPreferences.getString('token');
      final user_id = _sharedPreferences.getString('user_id');
      final photo = _sharedPreferences.getString('photo');
      final email = _sharedPreferences.getString('email');
      final role = _sharedPreferences.getString('role');
      final message = _sharedPreferences.getString('message');
      final statusCode = _sharedPreferences.getString('statusCode');
      return Right(
          [success, token, user_id, photo, email, role, message, statusCode]);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Clear User Data
  Future<Either<Failure, bool>> clear() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.clear(); // Clears all data in SharedPreferences
      return Right(true);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
