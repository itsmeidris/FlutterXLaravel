class Student {
  final int id;
  final String fullName;
  final String email;
  final int mark;

  Student({
    required this.fullName,
    required this.email,
    required this.mark,
    required this.id,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json["id"],
      fullName: json["name"],
      email: json["email"],
      mark: json["mark"],
    );
  }
}
