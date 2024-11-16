class ProblemChoiceModel {
  final int id;
  final int problemId;
  final String choiceTitle;
  final int choiceScore;
  final DateTime createdAt;

  ProblemChoiceModel({
    required this.id,
    required this.problemId,
    required this.choiceTitle,
    required this.choiceScore,
    required this.createdAt,
  });

  // JSON → TestModel 객체
  factory ProblemChoiceModel.fromJson(Map<String, dynamic> json) {
    return ProblemChoiceModel(
      id: json['id'],
      problemId: json['problem_id'],
      choiceTitle: json['choice_title'],
      choiceScore: json['choice_score'],
      createdAt: DateTime.parse(json['created_at']).add(Duration(hours: 9)),
    );
  }

  // TestModel 객체 → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'problem_id': problemId,
      'choice_title': choiceTitle,
      'choice_score': choiceScore,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
