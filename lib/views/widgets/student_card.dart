import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laravel_demo_app/models/student.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;
  const StudentCard({
    super.key,
    required this.student,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // shadow color
                blurRadius: 8, // blur effect
                spreadRadius: 2, // how much the shadow spreads
                offset: Offset(2, 4), // x and y offset
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl:
                        student.profileImage ??
                        'http://127.0.0.1:8000/storage/student_images/student_1756898515_n9LrF1F5LF.jpg', // Provide a fallback for null
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(), // Show loading indicator
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error), // Handle errors
                    fit: BoxFit.cover, // Adjust image scaling
                    width: 65, // Optional: set desired width
                    height: 65, // Optional: set desired height
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 15,
                      children: [
                        Text(
                          "Student's full name : ${student.fullName}",
                          style: _textStyle(),
                        ),
                        Text(
                          "Student's email : ${student.email}",
                          style: _textStyle(),
                        ),
                        Text(
                          "Student's mark : ${student.mark.toString()}",
                          style: _textStyle(),
                        ),
                        Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: onUpdate,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 21,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: onDelete,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 21,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle _textStyle() {
  return TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}
