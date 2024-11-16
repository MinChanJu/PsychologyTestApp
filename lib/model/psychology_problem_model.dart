class PsychologyProblemModel {
  final int id;
  final int testId;
  final String problemTitle;
  final DateTime createdAt;

  PsychologyProblemModel({
    required this.id,
    required this.testId,
    required this.problemTitle,
    required this.createdAt,
  });

  // JSON → TestModel 객체
  factory PsychologyProblemModel.fromJson(Map<String, dynamic> json) {
    return PsychologyProblemModel(
      id: json['id'],
      testId: json['test_id'],
      problemTitle: json['problem_title'],
      createdAt: DateTime.parse(json['created_at']).add(Duration(hours: 9)),
    );
  }

  // TestModel 객체 → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'test_id': testId,
      'problem_title': problemTitle,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
