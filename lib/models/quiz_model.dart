class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}

class QuizResult {
  final int score;
  final int totalQuestions;
  final DateTime dateTaken;
  final int correctAnswers;
  final int incorrectAnswers;

  QuizResult({
    required this.score,
    required this.totalQuestions,
    required this.dateTaken,
    required this.correctAnswers,
    required this.incorrectAnswers,
  });
}