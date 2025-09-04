import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:laravel_demo_app/models/student.dart';
import 'package:laravel_demo_app/services/api_service.dart';

class StudentController extends GetxController {
  //API SERVICE
  final ApiService _apiService = ApiService();

  //Reactive controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final markController = TextEditingController();
  final passwordController = TextEditingController();
  File? profileImage;

  //REACTIVE DATA
  RxList<Student> students = <Student>[].obs;
  RxBool isLoading = false.obs;

  //Student data
  RxString stdName = 'Student name'.obs;
  RxString stdEmail = 'Student email'.obs;
  RxInt stdMark = 0.obs;
  RxBool isRegistered = false.obs;
  File? stdImage;

  @override
  void onInit() {
    getStudents();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    markController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  //Get all students
  Future<void> getStudents() async {
    try {
      isLoading.value = true;
      final data = await _apiService.fetchStudents();
      students.assignAll(data);
    } catch (e) {
      debugPrint("Error in controller: $e");
    } finally {
      isLoading.value = false;
    }
  }

  //Delete a student
  Future<void> deleteStudent(int id) async {
    try {
      isLoading.value = true;
      bool success = await _apiService.deleteStudent(id);
      if (success) {
        isLoading.value = false;
        students.removeWhere((s) => s.id == id);
        Get.snackbar("Done", "Student got deleted");
      }
    } catch (e) {
      debugPrint('Error');
      Get.snackbar("Error", "Could not delete student");
    }
  }

  //Create new student
  Future<void> createStudent({
    required String name,
    required String email,
    required int mark,
    File? profileImage,
  }) async {
    try {
      isLoading.value = true;
      final result = await _apiService.createStudent(
        name: name,
        email: email,
        mark: mark,
        image: profileImage,
      );
      if (result["success"] == true) {
        isLoading.value = false;
        final newStudent = Student.fromJson(result['student']);
        students.add(newStudent);
        update();
      } else {
        isLoading.value = false;

        debugPrint(result["error"]);
      }
    } catch (e) {
      isLoading.value = false;

      debugPrint("Error while creating a student : $e");
    }
  }

  Future<void> registerStudent({
    required String name,
    required String email,
    required String password,
    required int mark,
    File? profileImage,
  }) async {
    try {
      isLoading.value = true;
      final result = await _apiService.registerStudent(
        name: name,
        email: email,
        password: password,
        mark: mark,
        image: profileImage,
      );
      if (result["success"] == true) {
        isLoading.value = false;
        isRegistered.value = true;
        final newStudent = Student.fromJson(result['student']);
        students.add(newStudent);
        update();
      } else {
        isLoading.value = false;

        debugPrint(result["error"]);
      }
    } catch (e) {
      isLoading.value = false;

      debugPrint("Error while creating a student : $e");
    }
  }
}
