import '../models/quiz_model.dart';
import 'dart:math';
import '../l10n/app_localizations.dart';

class QuizService {
  final Random _random = Random();

  List<QuizQuestion> getCharacterRecognitionQuiz(AppLocalizations l10n) {
    return [
      // Group 1: Arkab, Basigna, Darbai, Eh
      _createShuffledQuestion(
        id: '1',
        question: l10n.characterRecognitionQuestion('𖺠'),
        correctAnswer: l10n.arkab,
        allOptions: [l10n.arkab, l10n.basigna, l10n.darbai, l10n.eh],
        explanation: l10n.characterExplanation('𖺠', l10n.arkab),
      ),
      _createShuffledQuestion(
        id: '2',
        question: l10n.characterRecognitionQuestion('𖺡'),
        correctAnswer: l10n.basigna,
        allOptions: [l10n.arkab, l10n.basigna, l10n.darbai, l10n.eh],
        explanation: l10n.characterExplanation('𖺡', l10n.basigna),
      ),
      _createShuffledQuestion(
        id: '3',
        question: l10n.characterRecognitionQuestion('𖺢'),
        correctAnswer: l10n.darbai,
        allOptions: [l10n.arkab, l10n.basigna, l10n.darbai, l10n.eh],
        explanation: l10n.characterExplanation('𖺢', l10n.darbai),
      ),
      _createShuffledQuestion(
        id: '4',
        question: l10n.characterRecognitionQuestion('𖺣'),
        correctAnswer: l10n.eh,
        allOptions: [l10n.arkab, l10n.basigna, l10n.darbai, l10n.eh],
        explanation: l10n.characterExplanation('𖺣', l10n.eh),
      ),
      
      // Group 2: Fitko, Goway, Hirdeabo, I
      _createShuffledQuestion(
        id: '5',
        question: l10n.characterRecognitionQuestion('𖺤'),
        correctAnswer: l10n.fitko,
        allOptions: [l10n.fitko, l10n.goway, l10n.hirdeabo, l10n.i],
        explanation: l10n.characterExplanation('𖺤', l10n.fitko),
      ),
      _createShuffledQuestion(
        id: '6',
        question: l10n.characterRecognitionQuestion('𖺥'),
        correctAnswer: l10n.goway,
        allOptions: [l10n.fitko, l10n.goway, l10n.hirdeabo, l10n.i],
        explanation: l10n.characterExplanation('𖺥', l10n.goway),
      ),
      _createShuffledQuestion(
        id: '7',
        question: l10n.characterRecognitionQuestion('𖺦'),
        correctAnswer: l10n.hirdeabo,
        allOptions: [l10n.fitko, l10n.goway, l10n.hirdeabo, l10n.i],
        explanation: l10n.characterExplanation('𖺦', l10n.hirdeabo),
      ),
      _createShuffledQuestion(
        id: '8',
        question: l10n.characterRecognitionQuestion('𖺧'),
        correctAnswer: l10n.i,
        allOptions: [l10n.fitko, l10n.goway, l10n.hirdeabo, l10n.i],
        explanation: l10n.characterExplanation('𖺧', l10n.i),
      ),
      
      // Group 3: Djai, Kobo, Lakko, Meri
      _createShuffledQuestion(
        id: '9',
        question: l10n.characterRecognitionQuestion('𖺨'),
        correctAnswer: l10n.djai,
        allOptions: [l10n.djai, l10n.kobo, l10n.lakko, l10n.meri],
        explanation: l10n.characterExplanation('𖺨', l10n.djai),
      ),
      _createShuffledQuestion(
        id: '10',
        question: l10n.characterRecognitionQuestion('𖺩'),
        correctAnswer: l10n.kobo,
        allOptions: [l10n.djai, l10n.kobo, l10n.lakko, l10n.meri],
        explanation: l10n.characterExplanation('𖺩', l10n.kobo),
      ),
      _createShuffledQuestion(
        id: '11',
        question: l10n.characterRecognitionQuestion('𖺪'),
        correctAnswer: l10n.lakko,
        allOptions: [l10n.djai, l10n.kobo, l10n.lakko, l10n.meri],
        explanation: l10n.characterExplanation('𖺪', l10n.lakko),
      ),
      _createShuffledQuestion(
        id: '12',
        question: l10n.characterRecognitionQuestion('𖺫'),
        correctAnswer: l10n.meri,
        allOptions: [l10n.djai, l10n.kobo, l10n.lakko, l10n.meri],
        explanation: l10n.characterExplanation('𖺫', l10n.meri),
      ),
      
      // Group 4: Nini, Gna, Ngay, Oi
      _createShuffledQuestion(
        id: '13',
        question: l10n.characterRecognitionQuestion('𖺬'),
        correctAnswer: l10n.nini,
        allOptions: [l10n.nini, l10n.gna, l10n.ngay, l10n.oi],
        explanation: l10n.characterExplanation('𖺬', l10n.nini),
      ),
      _createShuffledQuestion(
        id: '14',
        question: l10n.characterRecognitionQuestion('𖺭'),
        correctAnswer: l10n.gna,
        allOptions: [l10n.nini, l10n.gna, l10n.ngay, l10n.oi],
        explanation: l10n.characterExplanation('𖺭', l10n.gna),
      ),
      _createShuffledQuestion(
        id: '15',
        question: l10n.characterRecognitionQuestion('𖺮'),
        correctAnswer: l10n.ngay,
        allOptions: [l10n.nini, l10n.gna, l10n.ngay, l10n.oi],
        explanation: l10n.characterExplanation('𖺮', l10n.ngay),
      ),
      _createShuffledQuestion(
        id: '16',
        question: l10n.characterRecognitionQuestion('𖺯'),
        correctAnswer: l10n.oi,
        allOptions: [l10n.nini, l10n.gna, l10n.ngay, l10n.oi],
        explanation: l10n.characterExplanation('𖺯', l10n.oi),
      ),
      
      // Group 5: Pi, Erigo, Erigo Tamura, Seri
      _createShuffledQuestion(
        id: '17',
        question: l10n.characterRecognitionQuestion('𖺰'),
        correctAnswer: l10n.pi,
        allOptions: [l10n.pi, l10n.erigo, l10n.erigoTamura, l10n.seri],
        explanation: l10n.characterExplanation('𖺰', l10n.pi),
      ),
      _createShuffledQuestion(
        id: '18',
        question: l10n.characterRecognitionQuestion('𖺱'),
        correctAnswer: l10n.erigo,
        allOptions: [l10n.pi, l10n.erigo, l10n.erigoTamura, l10n.seri],
        explanation: l10n.characterExplanation('𖺱', l10n.erigo),
      ),
      _createShuffledQuestion(
        id: '19',
        question: l10n.characterRecognitionQuestion('𖺲'),
        correctAnswer: l10n.erigoTamura,
        allOptions: [l10n.pi, l10n.erigo, l10n.erigoTamura, l10n.seri],
        explanation: l10n.characterExplanation('𖺲', l10n.erigoTamura),
      ),
      _createShuffledQuestion(
        id: '20',
        question: l10n.characterRecognitionQuestion('𖺳'),
        correctAnswer: l10n.seri,
        allOptions: [l10n.pi, l10n.erigo, l10n.erigoTamura, l10n.seri],
        explanation: l10n.characterExplanation('𖺳', l10n.seri),
      ),
      
      // Group 6: Shep, Tatasuwe, Ui, Wasse
      _createShuffledQuestion(
        id: '21',
        question: l10n.characterRecognitionQuestion('𖺴'),
        correctAnswer: l10n.shep,
        allOptions: [l10n.shep, l10n.tatasuwe, l10n.ui, l10n.wasse],
        explanation: l10n.characterExplanation('𖺴', l10n.shep),
      ),
      _createShuffledQuestion(
        id: '22',
        question: l10n.characterRecognitionQuestion('𖺵'),
        correctAnswer: l10n.tatasuwe,
        allOptions: [l10n.shep, l10n.tatasuwe, l10n.ui, l10n.wasse],
        explanation: l10n.characterExplanation('𖺵', l10n.tatasuwe),
      ),
      _createShuffledQuestion(
        id: '23',
        question: l10n.characterRecognitionQuestion('𖺶'),
        correctAnswer: l10n.ui,
        allOptions: [l10n.shep, l10n.tatasuwe, l10n.ui, l10n.wasse],
        explanation: l10n.characterExplanation('𖺶', l10n.ui),
      ),
      _createShuffledQuestion(
        id: '24',
        question: l10n.characterRecognitionQuestion('𖺷'),
        correctAnswer: l10n.wasse,
        allOptions: [l10n.shep, l10n.tatasuwe, l10n.ui, l10n.wasse],
        explanation: l10n.characterExplanation('𖺷', l10n.wasse),
      ),
      
      // Group 7: Ay
      _createShuffledQuestion(
        id: '25',
        question: l10n.characterRecognitionQuestion('𖺸'),
        correctAnswer: l10n.ay,
        allOptions: [l10n.ay, l10n.arkab, l10n.basigna, l10n.darbai],
        explanation: l10n.characterExplanation('𖺸', l10n.ay),
      ),
      
      // Reverse questions: Find the character
      _createShuffledQuestion(
        id: '26',
        question: l10n.characterRepresentationQuestion(l10n.arkab),
        correctAnswer: '𖺠',
        allOptions: ['𖺠', '𖺡', '𖺢', '𖺣'],
        explanation: l10n.reverseCharacterExplanation('𖺠', l10n.arkab),
      ),
      _createShuffledQuestion(
        id: '27', 
        question: l10n.characterRepresentationQuestion(l10n.basigna),
        correctAnswer: '𖺡',
        allOptions: ['𖺠', '𖺡', '𖺢', '𖺣'],
        explanation: l10n.reverseCharacterExplanation('𖺡', l10n.basigna),
      ),
      _createShuffledQuestion(
        id: '28',
        question: l10n.characterRepresentationQuestion(l10n.darbai),
        correctAnswer: '𖺢',
        allOptions: ['𖺠', '𖺡', '𖺢', '𖺣'],
        explanation: l10n.reverseCharacterExplanation('𖺢', l10n.darbai),
      ),
      _createShuffledQuestion(
        id: '29',
        question: l10n.characterRepresentationQuestion(l10n.eh),
        correctAnswer: '𖺣',
        allOptions: ['𖺠', '𖺡', '𖺢', '𖺣'],
        explanation: l10n.reverseCharacterExplanation('𖺣', l10n.eh),
      ),
      _createShuffledQuestion(
        id: '30',
        question: l10n.characterRepresentationQuestion(l10n.i),
        correctAnswer: '𖺧',
        allOptions: ['𖺤', '𖺥', '𖺦', '𖺧'],
        explanation: l10n.reverseCharacterExplanation('𖺧', l10n.i),
      ),
    ];
  }

  List<QuizQuestion> getVocabularyQuiz(AppLocalizations l10n) {
    return [
      _createShuffledQuestion(
        id: '1',
        question: l10n.vocabularyQuestion('𖺡𖺧𖺸𖺣'),
        correctAnswer: l10n.house,
        allOptions: [l10n.house, l10n.water, l10n.sun, l10n.tree],
        explanation: l10n.vocabularyExplanation('𖺡𖺧𖺸𖺣', l10n.house),
      ),
      _createShuffledQuestion(
        id: '2',
        question: l10n.vocabularyQuestion('𖺡̄𖺧'),
        correctAnswer: l10n.water,
        allOptions: [l10n.house, l10n.water, l10n.sun, l10n.tree],
        explanation: l10n.vocabularyExplanation('𖺡̄𖺧', l10n.water),
      ),
      _createShuffledQuestion(
        id: '3',
        question: l10n.vocabularyQuestion('𖺧𖺢𖺯'),
        correctAnswer: l10n.sun,
        allOptions: [l10n.house, l10n.water, l10n.sun, l10n.tree],
        explanation: l10n.vocabularyExplanation('𖺧𖺢𖺯', l10n.sun),
      ),
      _createShuffledQuestion(
        id: '4',
        question: l10n.vocabularyQuestion('𖺡𖺣𖺥𖺧𖺢𖺧'),
        correctAnswer: l10n.tree,
        allOptions: [l10n.house, l10n.water, l10n.sun, l10n.tree],
        explanation: l10n.vocabularyExplanation('𖺡𖺣𖺥𖺧𖺢𖺧', l10n.tree),
      ),
      _createShuffledQuestion(
        id: '5',
        question: l10n.vocabularyQuestion('𖺯'),
        correctAnswer: l10n.person,
        allOptions: [l10n.person, l10n.food, l10n.family, l10n.night],
        explanation: l10n.vocabularyExplanation('𖺯', l10n.person),
      ),
      _createShuffledQuestion(
        id: '6',
        question: l10n.vocabularyQuestion('𖺠𖺩𖺧𖺳𖺣'),
        correctAnswer: l10n.food,
        allOptions: [l10n.person, l10n.food, l10n.family, l10n.night],
        explanation: l10n.vocabularyExplanation('𖺠𖺩𖺧𖺳𖺣', l10n.food),
      ),
      _createShuffledQuestion(
        id: '7',
        question: l10n.vocabularyQuestion('𖺠𖺱𖺠'),
        correctAnswer: l10n.family,
        allOptions: [l10n.person, l10n.food, l10n.family, l10n.night],
        explanation: l10n.vocabularyExplanation('𖺠𖺱𖺠', l10n.family),
      ),
      _createShuffledQuestion(
        id: '8',
        question: l10n.vocabularyQuestion('𖺥𖺧𖺬𖺧'),
        correctAnswer: l10n.night,
        allOptions: [l10n.person, l10n.food, l10n.family, l10n.night],
        explanation: l10n.vocabularyExplanation('𖺥𖺧𖺬𖺧', l10n.night),
      ),
      _createShuffledQuestion(
        id: '9',
        question: l10n.vocabularyQuestion('𖺥̄𖺣𖺬𖺧'),
        correctAnswer: l10n.village,
        allOptions: [l10n.village, l10n.forest, l10n.mountain, l10n.river],
        explanation: l10n.vocabularyExplanation( '𖺥̄𖺣𖺬𖺧',l10n.village)
      ),
      _createShuffledQuestion(
        id: '10',
        question: l10n.vocabularyQuestion('𖺯𖺳𖺶'),
        correctAnswer: l10n.forest,
        allOptions: [l10n.village, l10n.forest, l10n.mountain, l10n.river],
        explanation: l10n.vocabularyExplanation('𖺯𖺳𖺶',l10n.forest),
      ),
      _createShuffledQuestion(
        id: '11',
        question: l10n.vocabularyQuestion('𖺦𖺠'),
        correctAnswer: l10n.mountain,
        allOptions: [l10n.village, l10n.forest, l10n.mountain, l10n.river],
        explanation: l10n.vocabularyExplanation('𖺦𖺠', l10n.mountain),
      ),
      _createShuffledQuestion(
        id: '12',
        question: l10n.vocabularyQuestion('𖺶𖺱𖺣'),
        correctAnswer: l10n.river,
        allOptions: [l10n.village, l10n.forest, l10n.mountain, l10n.river],
        explanation: l10n.vocabularyExplanation('𖺶𖺱𖺣', l10n.river),
      ),
      _createShuffledQuestion(
        id: '13',
        question: l10n.vocabularyQuestion('𖺨̄𖺧𖺸𖺣'),
        correctAnswer: l10n.fire,
        allOptions: [l10n.fire, l10n.sky, l10n.star, l10n.moon],
        explanation: l10n.vocabularyExplanation('𖺨̄𖺧𖺸𖺣',l10n.fire),
      ),
      _createShuffledQuestion(
        id: '14',
        question: l10n.vocabularyQuestion('𖺡̄𖺣𖺥𖺧'),
        correctAnswer: l10n.sky,
        allOptions: [l10n.fire, l10n.sky, l10n.star, l10n.moon],
        explanation: l10n.vocabularyExplanation('𖺡̄𖺣𖺥𖺧', l10n.sky),
      ),
      _createShuffledQuestion(
        id: '15',
        question: l10n.vocabularyQuestion('𖺫𖺠𖺱'),
        correctAnswer: l10n.star,
        allOptions: [l10n.fire, l10n.sky, l10n.star, l10n.moon],
        explanation: l10n.vocabularyExplanation('𖺫𖺠𖺱', l10n.star),
      ),
      _createShuffledQuestion(
        id: '16',
        question: l10n.vocabularyQuestion('𖺶𖺱𖺢𖺣𖺸'),
        correctAnswer: l10n.moon,
        allOptions: [l10n.fire, l10n.sky, l10n.star, l10n.moon],
        explanation: l10n.vocabularyExplanation('𖺶𖺱𖺢𖺣𖺸', l10n.moon),
      ),
      _createShuffledQuestion(
        id: '17',
        question: l10n.vocabularyQuestion('𖺫𖺶𖺸𖺧𖺵'),
        correctAnswer: l10n.ocean,
        allOptions: [l10n.ocean, l10n.rain, l10n.wind, l10n.earth],
        explanation: l10n.vocabularyExplanation('𖺫𖺶𖺸𖺧𖺵', l10n.ocean),
      ),
      _createShuffledQuestion(
        id: '18',
        question: l10n.vocabularyQuestion('𖺡̄𖺯𖺢𖺶'),
        correctAnswer: l10n.rain,
        allOptions: [l10n.ocean, l10n.rain, l10n.wind, l10n.earth],
        explanation: l10n.vocabularyExplanation('𖺡̄𖺯𖺢𖺶', l10n.rain),
      ),
      _createShuffledQuestion(
        id: '19',
        question: l10n.vocabularyQuestion('𖺣𖺤𖺧'),
        correctAnswer: l10n.wind,
        allOptions: [l10n.ocean, l10n.rain, l10n.wind, l10n.earth],
        explanation: l10n.vocabularyExplanation('𖺣𖺤𖺧', l10n.wind),
      ),
      _createShuffledQuestion(
        id: '20',
        question: l10n.vocabularyQuestion('𖺧𖺱𖺧'),
        correctAnswer: l10n.earth,
        allOptions: [l10n.ocean, l10n.rain, l10n.wind, l10n.earth],
        explanation: l10n.vocabularyExplanation('𖺧𖺱𖺧', l10n.earth),
      ),
    ];
  }

  List<QuizQuestion> getSentenceQuiz(AppLocalizations l10n) {
    return [
      _createShuffledQuestion(
        id: '1',
        question: l10n.sentenceQuestion(l10n.goodEvening),
        correctAnswer: '𖺬𖺠𖺱𖺥𖺶𖺲𖺧𖺸𖺠',
        allOptions: [
          '𖺬𖺣𖺥𖺣𖺸𖺠',
          '𖺬𖺠𖺱𖺥𖺶𖺲𖺧𖺸𖺠',
          '𖺵𖺠𖺢𖺠𖺱𖺠𖺸𖺲𖺧',
          '𖺯𖺳𖺳𖺯'
        ],
        explanation: l10n.sentenceExplanation( l10n.goodEvening, '𖺬𖺠𖺱𖺥𖺶𖺲𖺧𖺸𖺠'),
      ),
      _createShuffledQuestion(
        id: '2',
        question: l10n.sentenceQuestion(l10n.goodMorning),
        correctAnswer: '𖺬𖺣𖺥𖺣𖺸𖺠',
        allOptions: [
          '𖺬𖺣𖺥𖺣𖺸𖺠',
          '𖺬𖺠𖺱𖺥𖺶𖺲𖺧𖺸𖺠',
          '𖺵𖺠𖺢𖺠𖺱𖺠𖺸𖺲𖺧',
          '𖺯𖺳𖺳𖺯'
        ],
        explanation: l10n.sentenceExplanation(l10n.goodMorning,'𖺬𖺣𖺥𖺣𖺸𖺠'),
      ),
      _createShuffledQuestion(
        id: '3',
        question: l10n.sentenceQuestion(l10n.goodbye),
        correctAnswer: '𖺵𖺠𖺢𖺠𖺱𖺠𖺸𖺲𖺧',
        allOptions: [
          '𖺬𖺣𖺥𖺣𖺸𖺠',
          '𖺵𖺠𖺢𖺠𖺱𖺠𖺸𖺲𖺧',
          '𖺬𖺠𖺱𖺥𖺶𖺲𖺧𖺸𖺠',
          '𖺯𖺳𖺳𖺯'
        ],
        explanation: l10n.sentenceExplanation(l10n.goodbye, '𖺵𖺠𖺢𖺠𖺱𖺠𖺸𖺲𖺧'),
      ),
      _createShuffledQuestion(
        id: '4',
        question: l10n.sentenceQuestion(l10n.please),
        correctAnswer: '𖺯𖺳𖺳𖺯',
        allOptions: [
          '𖺬𖺣𖺥𖺣𖺸𖺠',
          '𖺬𖺠𖺱𖺥𖺶𖺲𖺧𖺸𖺠',
          '𖺵𖺠𖺢𖺠𖺱𖺠𖺸𖺲𖺧',
          '𖺯𖺳𖺳𖺯'
        ],
        explanation: l10n.sentenceExplanation(l10n.please, '𖺯𖺳𖺳𖺯'),
      ),
    ];
  }

  // Helper method to create a question with shuffled options
  QuizQuestion _createShuffledQuestion({
    required String id,
    required String question,
    required String correctAnswer,
    required List<String> allOptions,
    required String explanation,
  }) {
    // Create a copy of the options list
    final shuffledOptions = List<String>.from(allOptions);
    
    // Shuffle the options
    shuffledOptions.shuffle(_random);
    
    // Find the new index of the correct answer
    final correctAnswerIndex = shuffledOptions.indexOf(correctAnswer);
    
    return QuizQuestion(
      id: id,
      question: question,
      options: shuffledOptions,
      correctAnswerIndex: correctAnswerIndex,
      explanation: explanation,
    );
  }

  QuizResult calculateScore(List<QuizQuestion> questions, List<int?> userAnswers) {
    int correctAnswers = 0;
    
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] != null && userAnswers[i] == questions[i].correctAnswerIndex) {
        correctAnswers++;
      }
    }
    
    int score = (correctAnswers / questions.length * 100).round();
    
    return QuizResult(
      score: score,
      totalQuestions: questions.length,
      dateTaken: DateTime.now(),
      correctAnswers: correctAnswers,
      incorrectAnswers: questions.length - correctAnswers,
    );
  }

  // Helper method to get a subset of questions for shorter quizzes
  List<QuizQuestion> getQuizSubset(List<QuizQuestion> allQuestions, int count) {
    allQuestions.shuffle(_random);
    return allQuestions.take(count).toList();
  }
}