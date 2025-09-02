import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:laravel_demo_app/models/student.dart';
import 'package:laravel_demo_app/routes/api_routes.dart';

class ApiService {
  //Get students
  Future<List<Student>> fetchStudents() async {
    final response = await http.get(Uri.parse(ApiRoutes.baseUrl));

    try {
      Map<String, dynamic> jsonData = json.decode(response.body);
      if (jsonData["success"] == true) {
        List data = jsonData["data"];
        return data.map((s) => Student.fromJson(s)).toList();
      } else {
        debugPrint("API returned success = false");
        return [];
      }
    } catch (e) {
      debugPrint("Error while fetching students : $e");
      return [];
    }
  }

  //Delete student
  Future<bool> deleteStudent(int id) async {
    final response = await http.delete(Uri.parse('${ApiRoutes.baseUrl}/$id'));
    if (response.statusCode == 201) {
      return true;
    } else {
      debugPrint("Failed to delete student : ${response.body}");
      return false;
    }
  }

  //Get student by id
  Future<Student?> fetchStudentById(int id) async {
    final response = await http.get(Uri.parse('${ApiRoutes.baseUrl}/$id'));

    try {
      if (response.statusCode == 201) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        if (jsonData["sucsess"] == true) {
          return Student.fromJson(jsonData["data"]);
        } else {
          debugPrint("API returned success = false");
          return null;
        }
      }
    } catch (e) {}
  }
}
