import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laravel_demo_app/controllers/student_controller.dart';
import 'package:laravel_demo_app/views/widgets/student_card.dart';
import 'package:laravel_demo_app/views/widgets/student_dialog.dart';
import 'package:laravel_demo_app/views/widgets/student_dialog_update.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentController studentController = Get.put(StudentController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("S T U D E N T S    A P I", style: TextStyle(fontSize: 27)),
      ),
      body: Obx(() {
        if (studentController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (studentController.students.isEmpty) {
          return Center(child: Text('No users found'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (e) {
                    debugPrint("Input written: $e");
                  },
                  style: TextStyle(
                    color: Colors.black, // Text color
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter your name", // Hint text
                    hintStyle: TextStyle(
                      color: Colors.grey, // Hint text color
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true, // Fill the background
                    fillColor: Colors.grey[200], // Background color
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey, // Border color
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey, // Border when not focused
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.blue, // Border when focused
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: studentController.students.length,
                itemBuilder: (context, index) {
                  final student = studentController.students[index];
                  return StudentCard(
                    student: student,
                    onDelete: () => studentController.deleteStudent(student.id),
                    onUpdate: () {
                      studentDialogUpdate(context, student);

                      debugPrint(
                        "Student ID : ${studentController.students[index].id}",
                      );
                      //studentController.students[index];
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          studentDialog(context, studentController);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 5,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, size: 20),
              Text("Add a student", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
