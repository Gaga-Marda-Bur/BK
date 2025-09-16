import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/3d_card.dart';
import '../constants/colors.dart';
import '../services/storage_service.dart';
import '../models/favorite_model.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final StorageService _storageService = StorageService();
  List<Favorite> _favorites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await _storageService.getFavorites();
    if (!mounted) return;
    setState(() {
      _favorites = favorites.where((fav) => fav.isFavorite).toList();
      _isLoading = false;
    });
  }

  Future<void> _toggleFavorite(String id) async {
    await _storageService.toggleFavorite(id);
    await _loadFavorites();
    
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.favoriteUpdated),
        backgroundColor: AppColors.gold,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _clearAllFavorites() async {
    final loc = AppLocalizations.of(context)!;
    
    final bool? confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.darkGreen,
          title: Text(
            loc.clearFavoritesTitle,
            style: const TextStyle(color: AppColors.gold),
          ),
          content: Text(
            loc.clearFavoritesConfirm,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(loc.cancel,
                  style: const TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(loc.clearAll,
                  style: const TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      for (var favorite in _favorites) {
        await _storageService.toggleFavorite(favorite.id);
      }
      await _loadFavorites();
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.favoritesCleared),
          backgroundColor: AppColors.gold,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
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
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ThreeDCard(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            loc.myFavorites,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.gold,
                            ),
                          ),
                          if (_favorites.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.delete_sweep, color: Colors.red),
                              onPressed: _clearAllFavorites,
                              tooltip: loc.clearAll,
                            ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Expanded(
                      child: _favorites.isEmpty
                          ? ThreeDCard(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star_border, size: 64, color: AppColors.goldOpacity05),
                                  const SizedBox(height: 16),
                                  Text(
                                    loc.noFavorites,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    loc.addFavoritesHint,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: _favorites.length,
                              itemBuilder: (context, index) {
                                final favorite = _favorites[index];
                                return _buildFavoriteItem(favorite, loc);
                              },
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildFavoriteItem(Favorite favorite, AppLocalizations loc) {
    return Dismissible(
      key: Key(favorite.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white, size: 24),
      ),
      secondaryBackground: Container(
        color: Colors.blue,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.share, color: Colors.white, size: 24),
      ),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          _toggleFavorite(favorite.id);
        }
      },
      child: ThreeDCard(
        padding: const EdgeInsets.all(12),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.goldOpacity02,
              shape: BoxShape.circle,
            ),
            child: Icon(
              favorite.type == 'word' ? Icons.book : Icons.text_fields,
              color: AppColors.gold,
              size: 20,
            ),
          ),
          title: Text(
            favorite.content,
            style: const TextStyle(
              fontFamily: 'Kedebideri',
              fontSize: 20,
              color: Colors.white,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '${loc.addedOn} ${_formatDate(favorite.dateAdded)}',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          trailing: IconButton(
            icon: Icon(
              favorite.isFavorite ? Icons.star : Icons.star_border,
              color: favorite.isFavorite ? AppColors.gold : Colors.grey,
            ),
            onPressed: () => _toggleFavorite(favorite.id),
            tooltip: favorite.isFavorite ? loc.removeFavorite : loc.addToFavorites,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}