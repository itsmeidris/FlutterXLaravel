import 'package:flutter/material.dart';
import 'package:laravel_demo_app/models/student.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback onDelete;
  const StudentCard({super.key, required this.student, required this.onDelete});

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
                Text("Student's email : ${student.email}", style: _textStyle()),
                Text(
                  "Student's mark : ${student.mark.toString()}",
                  style: _textStyle(),
                ),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: Icon(Icons.edit, color: Colors.white, size: 21),
                    ),
                    ElevatedButton(
                      onPressed: onDelete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Icon(Icons.delete, color: Colors.white, size: 21),
                    ),
                  ],
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
    fontSize: 24,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}
