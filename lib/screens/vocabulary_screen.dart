import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../widgets/3d_card.dart';
import '../constants/colors.dart';
import '../services/storage_service.dart';
import '../models/favorite_model.dart';
import '../l10n/app_localizations.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final StorageService _storageService = StorageService();
  
  Map<String, bool> _favoriteStatus = {};
  List<bool> _favoriteAnimation = [];

  final List<Map<String, String>> commonWords = [
    {'word': '𖺡𖺧𖺸𖺣', 'meaning': 'Maison', 'audio': 'house.mp3'},
    {'word': '𖺡̄𖺧', 'meaning': 'Eau', 'audio': 'water.mp3'},
    {'word': '𖺧𖺢𖺯', 'meaning': 'Soleil', 'audio': 'sun.mp3'},
    {'word': '𖺡𖺣𖺥𖺧𖺢𖺧', 'meaning': 'Arbre', 'audio': 'tree.mp3'},
    {'word': '𖺯', 'meaning': 'Personne', 'audio': 'person.mp3'},
    {'word': '𖺠𖺩𖺧𖺳𖺣', 'meaning': 'Nourriture', 'audio': 'food.mp3'},
    {'word': '𖺠𖺱𖺠', 'meaning': 'Famille', 'audio': 'family.mp3'},
    {'word': '𖺥𖺧𖺬𖺧', 'meaning': 'Nuit', 'audio': 'night.mp3'},
    {'word': '𖺥̄𖺣𖺬𖺧', 'meaning': 'Village', 'audio': 'village.mp3'},
    {'word': '𖺯𖺳𖺶', 'meaning': 'Forêt', 'audio': 'forest.mp3'},
    {'word': '𖺦𖺠', 'meaning': 'Montagne', 'audio': 'mountain.mp3'},
    {'word': '𖺶𖺱𖺣', 'meaning': 'Rivière', 'audio': 'river.mp3'},
    {'word': '𖺨̄𖺧𖺸𖺣', 'meaning': 'Feu', 'audio': 'fire.mp3'},
    {'word': '𖺡̄𖺣𖺥𖺧', 'meaning': 'Ciel', 'audio': 'sky.mp3'},
    {'word': '𖺫𖺠𖺱', 'meaning': 'Étoile', 'audio': 'star.mp3'},
    {'word': '𖺶𖺱𖺢𖺣𖺸', 'meaning': 'Lune', 'audio': 'moon.mp3'},
    {'word': '𖺫𖺶𖺸𖺧𖺵', 'meaning': 'Océan', 'audio': 'ocean.mp3'},
    {'word': '𖺡̄𖺯𖺢𖺶', 'meaning': 'Pluie', 'audio': 'rain.mp3'},
    {'word': '̄𖺣𖺤𖺧', 'meaning': 'Vent', 'audio': 'wind.mp3'},
    {'word': '𖺧𖺱𖺧', 'meaning': 'Terre', 'audio': 'earth.mp3'},
  ];

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
    _favoriteAnimation = List.generate(commonWords.length, (index) => false);
  }

  Future<void> _loadFavoriteStatus() async {
    final favorites = await _storageService.getFavorites();
    for (var favorite in favorites) {
      _favoriteStatus[favorite.content] = favorite.isFavorite;
    }
    setState(() {});
  }

  bool _isFavorite(String word) => _favoriteStatus[word] ?? false;

  Future<void> _toggleFavorite(String word, String meaning, int index) async {
    final existingFavorites = await _storageService.getFavorites();
    final existingFavorite = existingFavorites.firstWhere(
      (fav) => fav.content == word,
      orElse: () => Favorite(
        id: '',
        content: '',
        dateAdded: DateTime.now(),
        type: '',
        isFavorite: false,
      ),
    );

    if (existingFavorite.id.isNotEmpty) {
      await _storageService.toggleFavorite(existingFavorite.id);
    } else {
      final favorite = Favorite(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: word,
        dateAdded: DateTime.now(),
        type: 'word',
        isFavorite: true,
      );
      await _storageService.saveFavorite(favorite);
    }

    setState(() => _favoriteStatus[word] = !_isFavorite(word));
    _animateFavorite(index);

    final l10n = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite(word)
              ? l10n.addedToFavorites(meaning)
              : l10n.removedFromFavorites(meaning),
        ),
        backgroundColor: AppColors.gold,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _animateFavorite(int index) {
    setState(() => _favoriteAnimation[index] = true);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _favoriteAnimation[index] = false);
    });
  }

  void _playSound(String audioFile) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('audio/$audioFile'));
    } catch (e) {
      print('Error playing sound: $e');
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.audioFileNotFound),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Material( // AJOUT: Encapsuler avec Material
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.darkGreen, AppColors.darkerGreen],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThreeDCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.vocabularyTitle,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.gold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.vocabularyDescription,
                      style: const TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.gold, size: 16),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            l10n.favoritesInstruction,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.gold.withAlpha(180),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: commonWords.length,
                itemBuilder: (context, index) {
                  final word = commonWords[index];
                  return _buildWordCard(word, index, l10n);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordCard(Map<String, String> word, int index, AppLocalizations l10n) {
    final isFavorite = _isFavorite(word['word']!);

    return ThreeDCard(
      padding: const EdgeInsets.all(12),
      child: Stack(
        children: [
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () => _toggleFavorite(word['word']!, word['meaning']!, index),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: _favoriteAnimation[index] ? 1.2 : 1.0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.blackOpacity05,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: isFavorite ? AppColors.gold : Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => _playSound(word['audio']!),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    word['word']!,
                    style: const TextStyle(
                      fontFamily: 'Kedebideri',
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  word['meaning']!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.goldOpacity02,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.volume_up,
                    color: AppColors.gold,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.tapToListen,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}