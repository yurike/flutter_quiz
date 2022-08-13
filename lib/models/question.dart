class Question {
  int id;
  String question;
  String? description;
  Map answers;
  bool multiple_correct_answers;
  Map correct_answers;
  String? explanation;
  String category;
  String difficulty;

  Question({
    required this.id,
    required this.question,
    required this.description,
    required this.answers,
    required this.multiple_correct_answers,
    required this.correct_answers,
    required this.explanation,
    required this.category,
    required this.difficulty,
  });

  Question.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        description = json['description'],
        answers = json['answers'],
        multiple_correct_answers = json['multiple_correct_answers'] == 'true',
        correct_answers = json['correct_answers'],
        explanation = json['explanation'],
        category = json['category'],
        difficulty = json['difficulty'];
}
