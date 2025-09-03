import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laravel_demo_app/controllers/student_controller.dart';
import 'package:laravel_demo_app/models/student.dart';

Future<void> studentDialogUpdate(BuildContext context, Student student) async {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final markController = TextEditingController();
  File? imageFile;
  String? existingImageUrl = student.profileImage;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 15,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Add Student",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Name input
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: student.fullName,
                        border: OutlineInputBorder(),
                      ),
                    ),

                    // Email input
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: student.email,
                        border: OutlineInputBorder(),
                      ),
                    ),

                    // Mark input
                    TextField(
                      controller: markController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: student.mark.toString(),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    // Upload picture
                    GestureDetector(
                      onTap: () async {
                        final pickedFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          setState(() {
                            imageFile = File(pickedFile.path);
                            existingImageUrl =
                                null; // clear URL when new image picked
                          });
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: imageFile != null
                              ? Image.file(
                                  imageFile!,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : (existingImageUrl != null
                                    ? Image.network(
                                        existingImageUrl!,
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Center(child: Text("Upload Picture"))),
                        ),
                      ),
                    ),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("Cancel"),
                        ),

                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Update"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
