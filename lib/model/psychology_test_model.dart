class PsychologyTestModel {
  final int id;
  final String title;
  final String description;
  final String createdBy;
  final DateTime createdAt;

  PsychologyTestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdBy,
    required this.createdAt,
  });

  // JSON → TestModel 객체
  factory PsychologyTestModel.fromJson(Map<String, dynamic> json) {
    return PsychologyTestModel(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? 'No Description',
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['created_at']).add(Duration(hours: 9)),
    );
  }

  // TestModel 객체 → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
