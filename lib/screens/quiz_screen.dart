import 'package:flutter/material.dart';
import '../widgets/3d_card.dart';
import '../widgets/quiz_widget.dart';
import '../constants/colors.dart';
import '../services/quiz_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizService _quizService = QuizService();
  int _selectedQuizIndex = 0;
  bool _quizStarted = false;

  final List<Map<String, dynamic>> _quizTypes = [
    {
      'title': 'Reconnaissance\nde caractères', // Ligne ajoutée
      'shortTitle': 'Caractères', // Titre court pour les petites cartes
      'description': 'Testez les caractères Beria Erfe',
      'icon': Icons.text_fields,
      'type': 'character',
    },
    {
      'title': 'Vocabulaire\nde base', // Ligne ajoutée
      'shortTitle': 'Vocabulaire',
      'description': 'Mots courants Beria Erfe',
      'icon': Icons.book,
      'type': 'vocabulary',
    },
    {
      'title': 'Phrases\nsimples', // Ligne ajoutée
      'shortTitle': 'Phrases',
      'description': 'Construction de phrases',
      'icon': Icons.chat,
      'type': 'sentence',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.darkGreen, AppColors.darkerGreen],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _quizStarted
            ? QuizWidget(
                quizService: _quizService,
                quizType: _selectedQuizIndex,
                quizTitle: _quizTypes[_selectedQuizIndex]['title'].replaceAll('\n', ' '), // Retirer les sauts de ligne
                onQuizFinished: () {
                  setState(() {
                    _quizStarted = false;
                  });
                },
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThreeDCard(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Quiz Interactif',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.9, // Ratio ajusté
                      ),
                      itemCount: _quizTypes.length,
                      itemBuilder: (context, index) {
                        return _buildQuizTypeCard(index);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildQuizTypeCard(int index) {
    final quizType = _quizTypes[index];
    return ThreeDCard(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedQuizIndex = index;
            _quizStarted = true;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(12.0),
          constraints: const BoxConstraints(
            minHeight: 140, // Hauteur minimale garantie
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Important pour éviter l'overflow
            children: [
              Icon(quizType['icon'], size: 32, color: AppColors.gold),
              const SizedBox(height: 8),
              Text(
                quizType['shortTitle'], // Utiliser le titre court
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                quizType['description'],
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}