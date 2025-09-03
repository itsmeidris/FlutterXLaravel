class Student {
  final int id;
  final String fullName;
  final String? profileImage;
  final String email;
  final int mark;

  Student({
    required this.fullName,
    required this.email,
    this.profileImage,
    required this.mark,
    required this.id,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json["id"],
      fullName: json["name"],
      profileImage: "http://127.0.0.1:8000${json["profile_image_url"]}",
      email: json["email"],
      mark: int.tryParse(json['mark'].toString()) ?? 0, // <-- safe parsing
    );
  }

  @override
  String toString() {
    return 'Student ($id) ($fullName) ($email) ($mark) ($profileImage) ';
  }
}
