import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/constants/hive_table_constant.dart';
import '../../features/batch/data/model/batch_hive_model.dart';
import '../../features/course/data/model/course_hive_model.dart';
import '../../features/retreat/data/model/retreat_hive_model.dart';

class HiveService {
  Future<void> init() async {
    //Initialize the Database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}nirlipta_yoga.db';

    //Create Database
    Hive.init(path);

    //Register Adapters
    Hive.registerAdapter(CourseHiveModelAdapter());
    Hive.registerAdapter(BatchHiveModelAdapter());
    Hive.registerAdapter(RetreatHiveModelAdapter());
    // Hive.registerAdapter(AuthHiveModelAdapter()); //Need to Add in Future Integration once .g (Generated) Adapter class is created
  }

  // Batch Queries
  Future<void> addBatch(BatchHiveModel batch) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.put(batch.batchId, batch);
  }

  Future<void> deleteBatch(String batchId) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.delete(batchId);
  }

  Future<List<BatchHiveModel>> getAllBatches() async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    var batches = box.values.toList();
    return batches;
  }

// Course Queries
  Future<void> addCourse() async {}

  Future<void> deleteCourse() async {}

  Future<void> getAllCourses() async {}

// Student Queries
  Future<void> addStudent() async {}

  Future<void> deleteStudent() async {}

  Future<void> getAllStudents() async {}

  Future<void> loginStudent(String username, String password) async {}

  // Retreat Queries
  Future<void> addRetreat(RetreatHiveModel retreat) async {
    var box =
        await Hive.openBox<RetreatHiveModel>(HiveTableConstant.retreatBox);
    await box.put(retreat.retreatId, retreat);
  }

  Future<void> deleteRetreat(String retreatId) async {
    var box =
        await Hive.openBox<RetreatHiveModel>(HiveTableConstant.retreatBox);
    await box.delete(retreatId);
  }

  Future<List<RetreatHiveModel>> getAllRetreats() async {
    var box =
        await Hive.openBox<RetreatHiveModel>(HiveTableConstant.retreatBox);
    return box.values.toList();
  }

  Future<RetreatHiveModel> getRetreatById(String retreatId) async {
    var box =
        await Hive.openBox<RetreatHiveModel>(HiveTableConstant.retreatBox);
    final retreat = box.get(retreatId);
    if (retreat == null) {
      throw Exception('Retreat with ID $retreatId not found');
    }
    return retreat;
  }

  Future<void> updateRetreat(String retreatId, RetreatHiveModel retreat) async {
    var box =
        await Hive.openBox<RetreatHiveModel>(HiveTableConstant.retreatBox);
    await box.put(retreatId, retreat);
  }

  Future<void> patchRetreat(String retreatId, RetreatHiveModel retreat) async {
    var box =
        await Hive.openBox<RetreatHiveModel>(HiveTableConstant.retreatBox);
    await box.put(
        retreatId, retreat); // In practice, you'd merge only the changed fields
  }
}
