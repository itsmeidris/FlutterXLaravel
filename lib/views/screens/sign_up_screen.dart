import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laravel_demo_app/controllers/student_controller.dart';
import 'package:laravel_demo_app/routes/app_routes.dart';
import 'package:laravel_demo_app/views/widgets/shared/input_field.dart';
import 'package:laravel_demo_app/views/widgets/shared/shared_app_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //Find the controller
  final studentController = Get.find<StudentController>(); // retrieve

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              width: MediaQuery.of(context).size.width * .85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Create a new account",
                        style: TextStyle(color: Colors.white, fontSize: 27),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputField(
                      textEditingController: studentController.nameController,
                      hintText: "Enter your name",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputField(
                      textEditingController: studentController.markController,
                      hintText: "Enter your mark",
                      textInputType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputField(
                      textEditingController: studentController.emailController,
                      hintText: "Enter your email",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputField(
                      textEditingController:
                          studentController.passwordController,
                      hintText: "Enter your password",
                      label: "password",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final pickedFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          setState(() {
                            studentController.profileImage = File(
                              pickedFile.path,
                            );
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,

                            children: [
                              Icon(Icons.add, color: Colors.white),
                              Center(
                                child: Text(
                                  "Upload a profile picture",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    child: Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              studentController.registerStudent(
                                name: studentController.nameController.text
                                    .toString(),
                                email: studentController.emailController.text
                                    .toString(),
                                password: studentController
                                    .passwordController
                                    .text
                                    .toString(),
                                mark:
                                    int.tryParse(
                                      studentController.markController.text
                                          .trim(),
                                    ) ??
                                    0,
                              );
                              debugPrint(studentController.stdMark.toString());
                              if (studentController.isRegistered.value ==
                                  true) {
                                AppRoutes.appRouter.goNamed("signin");
                              } else {
                                debugPrint("NOPE !");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(5),
                              ),
                            ),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 12.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        debugPrint('dfede');
                        AppRoutes.appRouter.goNamed("signin");
                      },
                      child: Text(
                        "Already have an account ?",

                        style: TextStyle(
                          color: Colors.white,
                          decorationColor: Colors.white,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
