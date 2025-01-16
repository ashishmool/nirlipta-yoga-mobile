import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/constants/hive_table_constant.dart';
import '../../features/auth/data/model/student_hive_model.dart';
import '../../features/batch/data/model/batch_hive_model.dart';
import '../../features/course/data/model/course_hive_model.dart';
import '../../features/workshop/data/model/workshop_hive_model.dart';

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
    Hive.registerAdapter(StudentHiveModelAdapter());
    Hive.registerAdapter(WorkshopHiveModelAdapter());
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
  Future<void> addCourse(CourseHiveModel course) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    await box.put(course.courseId, course);
  }

  Future<void> deleteCourse(String courseId) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    await box.delete(courseId);
  }

  Future<List<CourseHiveModel>> getAllCourses() async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    var courses = box.values.toList();
    return courses;
  }

// Student Queries

  Future<void> addStudent(StudentHiveModel student) async {
    var box =
        await Hive.openBox<StudentHiveModel>(HiveTableConstant.studentBox);
    await box.put(student.id, student);
  }

  Future<void> deleteStudent(String id) async {
    var box =
        await Hive.openBox<StudentHiveModel>(HiveTableConstant.studentBox);
    await box.delete(id);
  }

  Future<List<StudentHiveModel>> getAllStudents() async {
    var box =
        await Hive.openBox<StudentHiveModel>(HiveTableConstant.studentBox);
    var students = box.values.toList();
    return students;
  }

  Future<StudentHiveModel?> loginStudent(String email, String password) async {
    var box =
        await Hive.openBox<StudentHiveModel>(HiveTableConstant.studentBox);

    var auth = box.values.firstWhere(
        (element) => element.email == email && element.password == password,
        orElse: () => StudentHiveModel.initial());

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
}
