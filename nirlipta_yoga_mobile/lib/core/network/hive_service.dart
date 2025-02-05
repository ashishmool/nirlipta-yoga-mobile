import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/constants/hive_table_constant.dart';
import '../../features/auth/data/model/user_hive_model.dart';
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
  }

// User Queries

  Future<void> addUser(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.put(user.id, user);
  }

  Future<void> deleteUser(String id) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<UserHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    var users = box.values.toList();
    return users;
  }

  Future<UserHiveModel?> loginUser(String email, String password) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);

    var auth = box.values.firstWhere(
        (element) => element.email == email && element.password == password,
        orElse: () => UserHiveModel.initial());

    return auth;
  }

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
}
