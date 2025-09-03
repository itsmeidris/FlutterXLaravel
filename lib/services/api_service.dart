import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
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

  //Create a student
  Future<Map<String, dynamic>> createStudent({
    required String name,
    required String email,
    required int mark,
    File? image,
  }) async {
    //For sending images
    final request = http.MultipartRequest('POST', Uri.parse(ApiRoutes.baseUrl));

    //Add fields
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['mark'] = mark.toString();

    //Set image extensions
    final ext = path
        .extension(image!.path)
        .toLowerCase()
        .replaceAll('.', ''); // e.g., 'png', 'jpg'
    final mimeType = MediaType('image', ext);
    //Add image is exists
    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_image',
          image.path,
          contentType: mimeType,
        ),
      );
    }

    //Get response
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    // Print the raw response from the server
    debugPrint("Server response: $responseString");
    try {
      final jsonResponse = json.decode(responseString);
      if (response.statusCode == 201) {
        debugPrint("Decoded JSON response: $jsonResponse");
        // Return the actual student object
        return {
          'success': true,
          'message': jsonResponse['message'],
          'student': jsonResponse['student'],
        };
      } else {
        return {'success': false, 'error': jsonResponse['message']};
      }
    } catch (e) {
      debugPrint("Error while creating a student from service : $e");
      return {'success': false, 'errors': 'Invalid response from server'};
    }
  }
}
