// Une tache
class Task {
  final String id;
  final String title;
  String? description;
  bool isCompleted;
  DateTime dateCreated;
  DateTime? dateEcheance;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? dateCreated,
    DateTime? dateEcheance,
  }) : dateCreated = dateCreated ?? DateTime.now();

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'dateCreated': dateCreated.toIso8601String(),
      'dateEcheance': dateEcheance?.toIso8601String(),
    };
  }

  // fromJson
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      dateCreated: DateTime.parse(json['dateCreated']),
      dateEcheance: json['dateEcheance'] != null
          ? DateTime.parse(json['dateEcheance'])
          : null,
    );
  }
  
}
