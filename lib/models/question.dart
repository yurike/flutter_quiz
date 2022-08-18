class Question {
  int id;
  String question;
  String? description;
  Map answers;
  bool multipleCorrectAnswers;
  Map correctAnswers;
  String? explanation;
  String category;
  String difficulty;

  Question({
    required this.id,
    required this.question,
    required this.description,
    required this.answers,
    required this.multipleCorrectAnswers,
    required this.correctAnswers,
    required this.explanation,
    required this.category,
    required this.difficulty,
  });

  Question.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        description = json['description'],
        answers = json['answers'],
        multipleCorrectAnswers = json['multiple_correct_answers'] == 'true',
        correctAnswers = json['correct_answers'],
        explanation = json['explanation'],
        category = json['category'],
        difficulty = json['difficulty'];
}
