class Course{

  final int userId;
  final int id;
  final String title;
  final bool completed;

  const Course({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed
  });
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed']
    );
  }
}
