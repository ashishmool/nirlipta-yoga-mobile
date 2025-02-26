import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/constants/hive_table_constant.dart';
import '../../features/auth/data/model/user_hive_model.dart';
import '../../features/enrollment/data/model/enrollment_hive_model.dart';
import '../../features/workshop/data/model/workshop_hive_model.dart';
import '../../features/workshop_category/data/model/category_hive_model.dart';

class HiveService {
  Future<void> init() async {
    //Initialize the Database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}nirlipta_yoga.db';

    //Create Database
    Hive.init(path);

    //Register Adapters
    Hive.registerAdapter(UserHiveModelAdapter());
    Hive.registerAdapter(CategoryHiveModelAdapter());
    Hive.registerAdapter(WorkshopHiveModelAdapter());
    Hive.registerAdapter(EnrollmentHiveModelAdapter());
  }

// User Queries

  /// Adds a new user
  Future<void> addUser(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.put(user.id, user);
  }

  /// Deletes a user by ID
  Future<void> deleteUser(String id) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  /// Retrieves all users
  Future<List<UserHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  /// Retrieves a user by ID
  Future<UserHiveModel?> getUserById(String userId) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    return box.get(userId);
  }

  /// Updates an existing user
  Future<void> updateUser(
      String userId, String token, Map<String, dynamic> updatedData) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    var existingUser = box.get(userId);

    if (existingUser != null) {
      var updatedUser = UserHiveModel(
        id: userId,
        name: updatedData['name'] ?? existingUser.name,
        email: updatedData['email'] ?? existingUser.email,
        password: updatedData['password'] ?? existingUser.password,
        photo: updatedData['photo'] ?? existingUser.photo,
        username: existingUser.username,
        phone: updatedData['phone'] ?? existingUser.phone,
        gender: updatedData['gender'] ?? existingUser.gender,
        role: existingUser.role,
      );

      await box.put(userId, updatedUser);
    }
  }

  /// Logs in a user
  Future<UserHiveModel?> loginUser(String email, String password) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);

    return box.values.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => UserHiveModel.initial(),
    );
  }

  /// Sends an OTP to the user’s email for password reset
  Future<String?> receiveOtp(String email) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere((user) => user.email == email,
        orElse: () => UserHiveModel.initial());

    if (user.id != null) {
      String otp = generateOtp(); // Generate a 6-digit OTP
      var updatedUser = user.copyWith(otp: otp);

      await box.put(user.id, updatedUser);
      return otp;
    }
    return null;
  }

  /// Verifies OTP and updates the user's password
  Future<bool> setNewPassword(
      String email, String otp, String newPassword) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere((user) => user.email == email,
        orElse: () => UserHiveModel.initial());

    if (user.id != null && user.otp == otp) {
      var updatedUser = user.copyWith(
          password: newPassword, otp: null); // Clear OTP after reset

      await box.put(user.id, updatedUser);
      return true; // Password reset successful
    }
    return false; // OTP mismatch or user not found
  }

  //
  // /// Clears all users (for debugging purposes)
  // Future<void> clearUsers() async {
  //   var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
  //   await box.clear();
  // }

  // Workshop Queries
  Future<void> addWorkshop(WorkshopHiveModel workshop) async {
    var box =
        await Hive.openBox<WorkshopHiveModel>(HiveTableConstant.workshopBox);
    await box.put(workshop.workshopId, workshop);
  }

  Future<void> deleteWorkshop(String workshopId) async {
    var box =
        await Hive.openBox<WorkshopHiveModel>(HiveTableConstant.workshopBox);
    await box.delete(workshopId);
  }

  Future<List<WorkshopHiveModel>> getAllWorkshops() async {
    var box =
        await Hive.openBox<WorkshopHiveModel>(HiveTableConstant.workshopBox);
    return box.values.toList();
  }

  Future<WorkshopHiveModel?> getWorkshopById(String workshopId) async {
    var box =
        await Hive.openBox<WorkshopHiveModel>(HiveTableConstant.workshopBox);
    return box.get(workshopId);
  }

  Future<void> updateWorkshop(WorkshopHiveModel workshop) async {
    var box =
        await Hive.openBox<WorkshopHiveModel>(HiveTableConstant.workshopBox);
    await box.put(workshop.workshopId, workshop);
  }

  // Category Queries
  Future<void> addCategory(CategoryHiveModel category) async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    await box.put(category.id, category);
  }

  Future<void> deleteCategory(String id) async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    await box.delete(id);
  }

  Future<List<CategoryHiveModel>> getAllCategories() async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    return box.values.toList();
  }

  Future<CategoryHiveModel?> getCategoryById(String id) async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    return box.get(id);
  }

  Future<void> updateCategory(CategoryHiveModel category) async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    await box.put(category.id, category);
  }

  // Enrollment Queries
  Future<void> addEnrollment(EnrollmentHiveModel enrollment) async {
    var box = await Hive.openBox<EnrollmentHiveModel>(
        HiveTableConstant.enrollmentBox);
    await box.put(enrollment.id, enrollment);
  }

  Future<void> deleteEnrollment(String id) async {
    var box = await Hive.openBox<EnrollmentHiveModel>(
        HiveTableConstant.enrollmentBox);
    await box.delete(id);
  }

  Future<List<EnrollmentHiveModel>> getAllEnrollments() async {
    var box = await Hive.openBox<EnrollmentHiveModel>(
        HiveTableConstant.enrollmentBox);
    return box.values.toList();
  }

  Future<EnrollmentHiveModel?> getEnrollmentById(String id) async {
    var box = await Hive.openBox<EnrollmentHiveModel>(
        HiveTableConstant.enrollmentBox);
    return box.get(id);
  }

  Future<void> updateEnrollment(EnrollmentHiveModel enrollment) async {
    var box = await Hive.openBox<EnrollmentHiveModel>(
        HiveTableConstant.enrollmentBox);
    await box.put(enrollment.id, enrollment);
  }
}

String generateOtp() {
  return (100000 + (DateTime.now().millisecondsSinceEpoch % 900000)).toString();
}
