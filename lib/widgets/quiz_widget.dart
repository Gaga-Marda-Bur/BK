// Remplace ton fichier quiz_widget.dart par ceci (ou adapte)
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/quiz_model.dart';
import '../services/quiz_service.dart';
import '../l10n/app_localizations.dart';

class QuizWidget extends StatefulWidget {
  final QuizService quizService;
  final int quizType;
  final String quizTitle;
  final Function() onQuizFinished;

  const QuizWidget({
    super.key,
    required this.quizService,
    required this.quizType,
    required this.quizTitle,
    required this.onQuizFinished,
  });

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  late List<QuizQuestion> _questions;
  int _currentQuestionIndex = 0;
  List<int?> _userAnswers = [];
  bool _quizCompleted = false;
  QuizResult? _quizResult;
  bool _questionsLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_questionsLoaded) {
      _loadQuestions();
      _questionsLoaded = true;
    }
  }

  void _loadQuestions() {
    final l10n = AppLocalizations.of(context)!;

    switch (widget.quizType) {
      case 0:
        _questions = widget.quizService.getCharacterRecognitionQuiz(l10n);
        break;
      case 1:
        _questions = widget.quizService.getVocabularyQuiz(l10n);
        break;
      case 2:
        _questions = widget.quizService.getSentenceQuiz(l10n);
        break;
      default:
        _questions = widget.quizService.getCharacterRecognitionQuiz(l10n);
    }
    _userAnswers = List.filled(_questions.length, null);
    setState(() {});
  }

  void _answerQuestion(int answerIndex) {
    setState(() {
      _userAnswers[_currentQuestionIndex] = answerIndex;
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _completeQuiz();
      }
    });
  }

  void _completeQuiz() {
    _quizResult = widget.quizService.calculateScore(_questions, _userAnswers);
    setState(() {
      _quizCompleted = true;
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _userAnswers = List.filled(_questions.length, null);
      _quizCompleted = false;
      _quizResult = null;
    });
  }

  void _goToPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _goToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  // --- helper: returns TextStyle using Kedebideri only for character quiz (index 0)
  TextStyle _questionTextStyle({double size = 20}) {
    if (widget.quizType == 0 || widget.quizType == 1 || widget.quizType == 2) {
      return TextStyle(
        fontFamily: 'Kedebideri', // doit correspondre à pubspec.yaml
        fontFamilyFallback: const ['NotoSans', 'Roboto'], // secours si glyphe manquant
        fontSize: size,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        height: 1.05,
      );
    }
    return TextStyle(fontSize: size, color: Colors.white, fontWeight: FontWeight.bold);
  }

  TextStyle _optionTextStyle() {
    if (widget.quizType == 0 || widget.quizType == 1|| widget.quizType == 2) {
      return const TextStyle(
        fontFamily: 'Kedebideri',
        fontFamilyFallback: ['NotoSans', 'Roboto'],
        fontSize: 16,
        color: Colors.white,
      );
    }
    return const TextStyle(fontSize: 16, color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (!_questionsLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_quizCompleted) {
      return _buildResultsScreen(l10n);
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

   

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.gold),
                onPressed: () {
                  if (_currentQuestionIndex == 0) {
                    widget.onQuizFinished();
                  } else {
                    _goToPreviousQuestion();
                  }
                },
              ),
              Expanded(
                child: Text(
                  widget.quizTitle,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: AppColors.gold),
                onPressed: widget.onQuizFinished,
              ),
            ],
          ),
        ),

        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.darkGreen,
          color: AppColors.gold,
          minHeight: 8,
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${l10n.question} ${_currentQuestionIndex + 1}/${_questions.length}',
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 20),

                // Question card (applique la font Kedebideri pour quizType == 0)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.darkerGreen,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.gold),
                  ),
                  child: Text(
                    currentQuestion.question,
                    style: _questionTextStyle(size: 22),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 30),

                // Options
                Column(
                  children: currentQuestion.options.asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ElevatedButton(
                        onPressed: () => _answerQuestion(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _userAnswers[_currentQuestionIndex] == index
                              ? AppColors.gold
                              : AppColors.darkGreen,
                          foregroundColor: _userAnswers[_currentQuestionIndex] == index
                              ? AppColors.darkGreen
                              : Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: AppColors.gold),
                          ),
                        ),
                        child: Text(option, style: _optionTextStyle()),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _currentQuestionIndex > 0 ? _goToPreviousQuestion : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkGreen,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(l10n.previous),
                    ),
                    ElevatedButton(
                      onPressed: _currentQuestionIndex < _questions.length - 1 ? _goToNextQuestion : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.darkGreen,
                      ),
                      child: Text(l10n.next),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultsScreen(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.quizFinished,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.darkerGreen,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gold),
            ),
            child: Column(
              children: [
                Text(
                  '${_quizResult!.score} % ${l10n.score}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _quizResult!.score >= 70 ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '${_quizResult!.correctAnswers} ${l10n.correctAnswersOf} ${_quizResult!.totalQuestions}',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: _quizResult!.score / 100,
                  backgroundColor: AppColors.darkGreen,
                  color: _quizResult!.score >= 70 ? Colors.green : Colors.red,
                  minHeight: 10,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _restartQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: AppColors.darkGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(l10n.restart),
              ),
              ElevatedButton(
                onPressed: widget.onQuizFinished,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  side: BorderSide(color: AppColors.gold),
                ),
                child: Text(l10n.back),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
