class TaskModel {
  String title;
  String description;
  bool completed;
  DateTime lastModifiedDateTime;

  TaskModel({
    required this.title,
    required this.description,
    required this.completed,
    required this.lastModifiedDateTime,
  });

  factory TaskModel.fromJson(Map<String, dynamic> data, String name) {
    return TaskModel(
      title: name,
      description: data["description"],
      completed: data["completed"],
      lastModifiedDateTime: DateTime.parse(data["last_modified_date_time"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "completed": completed,
      "last_modified_date_time": lastModifiedDateTime.toString(),
    };
  }
}
