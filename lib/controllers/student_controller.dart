import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:laravel_demo_app/models/student.dart';
import 'package:laravel_demo_app/services/api_service.dart';

class StudentController extends GetxController {
  //API SERVICE
  final ApiService _apiService = ApiService();

  //REACTIVE DATA
  RxList<Student> students = <Student>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getStudents();
    super.onInit();
  }

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
}
