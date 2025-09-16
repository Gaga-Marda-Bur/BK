import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/3d_card.dart';
import '../widgets/image_gallery.dart';
import '../constants/colors.dart';
import '../services/storage_service.dart';
import '../models/favorite_model.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int _selectedCategory = 0;
  final StorageService _storageService = StorageService();
  Map<String, bool> _favoriteStatus = {};
  List<Map<String, dynamic>> _categories = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeCategories();
  }

  void _initializeCategories() {
    final loc = AppLocalizations.of(context)!;

    _categories = [
      {
        'title': loc.categoryCharacters,
        'icon': Icons.text_fields,
        'images': [
          {
            'path': 'assets/images/characters/arkab.png',
            'title': '${loc.character} Arkab (𖺠)',
            'character': '𖺠'
          },
          {
            'path': 'assets/images/characters/basinga.png',
            'title': '${loc.character} Basigna (𖺡)',
            'character': '𖺡'
          },
          {
            'path': 'assets/images/characters/darbai.png',
            'title': '${loc.character} Darbai (𖺢)',
            'character': '𖺢'
          },
          {
            'path': 'assets/images/characters/eh.png',
            'title': '${loc.character} Eh (𖺣)',
            'character': '𖺣'
          },
        ],
      },
      {
        'title': loc.categoryWords,
        'icon': Icons.book,
        'images': [
          {
            'path': 'assets/images/words/maison.png',
            'title': '${loc.word} Maison (𖺠𖺡𖺢)',
            'character': '𖺠𖺡𖺢'
          },
          {
            'path': 'assets/images/words/eau.png',
            'title': '${loc.word} Eau (𖺣𖺤𖺥)',
            'character': '𖺣𖺤𖺥'
          },
          {
            'path': 'assets/images/words/soleil.png',
            'title': '${loc.word} Soleil (𖺦𖺧𖺨)',
            'character': '𖺦𖺧𖺨'
          },
          {
            'path': 'assets/images/words/arbre.png',
            'title': '${loc.word} Arbre (𖺩𖺪𖺫)',
            'character': '𖺩𖺪𖺫'
          },
        ],
      },
      {
        'title': loc.categoryCulture,
        'icon': Icons.celebration,
        'images': [
          {
            'path': 'assets/images/culture/art.png',
            'title': loc.traditionalArt,
            'character': '🎨'
          },
          {
            'path': 'assets/images/culture/ceremonie.png',
            'title': loc.traditionalCeremony,
            'character': '🎭'
          },
          {
            'path': 'assets/images/culture/costume.png',
            'title': loc.traditionalCostumes,
            'character': '👘'
          },
          {
            'path': 'assets/images/culture/artisanat.png',
            'title': loc.localCrafts,
            'character': '🏺'
          },
        ],
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final favorites = await _storageService.getFavorites();
    for (var favorite in favorites) {
      _favoriteStatus[favorite.content] = favorite.isFavorite;
    }
    setState(() {});
  }

  bool _isFavorite(String content) {
    return _favoriteStatus[content] ?? false;
  }

  Future<void> _toggleFavorite(String content, String type) async {
    final existingFavorites = await _storageService.getFavorites();
    final existingFavorite = existingFavorites.firstWhere(
      (fav) => fav.content == content,
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
        content: content,
        dateAdded: DateTime.now(),
        type: type,
        isFavorite: true,
      );
      await _storageService.saveFavorite(favorite);
    }

    setState(() {
      _favoriteStatus[content] = !_isFavorite(content);
    });

    final loc = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite(content)
              ? loc.addedToFavorites(content)
              : loc.removedFromFavorites(content),
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: AppColors.gold,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.darkGreen, AppColors.darkerGreen],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ThreeDCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.galleryTitle,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.gold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            loc.gallerySubtitle,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.star, color: AppColors.gold),
                      onPressed: () {
                        Navigator.pushNamed(context, '/favorites');
                      },
                      tooltip: loc.favorites,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Sélecteur de catégories
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(category['icon'], size: 16),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                category['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        selected: _selectedCategory == index,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = index;
                          });
                        },
                        selectedColor: AppColors.gold,
                        labelStyle: TextStyle(
                          color: _selectedCategory == index
                              ? AppColors.darkGreen
                              : Colors.white,
                          fontWeight: _selectedCategory == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        backgroundColor: AppColors.darkGreen,
                        side: const BorderSide(color: AppColors.gold),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Indicateur de catégorie
              ThreeDCard(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _categories[_selectedCategory]['icon'],
                      color: AppColors.gold,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        _categories[_selectedCategory]['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: _categories[_selectedCategory]['images'].isEmpty
                    ? ThreeDCard(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              size: 64,
                              color: AppColors.goldOpacity05,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              loc.noImage,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              loc.comingSoon,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white54,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    : ImageGallery(
                        images: _categories[_selectedCategory]['images'],
                        onToggleFavorite: (image) {
                          final type = _selectedCategory == 0
                              ? 'character'
                              : _selectedCategory == 1
                                  ? 'word'
                                  : 'culture';
                          _toggleFavorite(image['character'], type);
                        },
                        isFavorite: (image) => _isFavorite(image['character']),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
