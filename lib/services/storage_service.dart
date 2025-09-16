import 'package:shared_preferences/shared_preferences.dart';
import '../models/favorite_model.dart';
import '../models/history_model.dart';
import 'dart:convert';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  // Favorites
  static const String _favoritesKey = 'favorites';

  Future<List<Favorite>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String favoritesString = prefs.getString(_favoritesKey) ?? '[]';
    final List<dynamic> favoritesJson = json.decode(favoritesString);
    return favoritesJson.map((json) => Favorite.fromMap(json)).toList();
  }

  Future<void> saveFavorite(Favorite favorite) async {
    final List<Favorite> favorites = await getFavorites();
    favorites.add(favorite);
    await _saveFavorites(favorites);
  }

  Future<void> removeFavorite(String id) async {
    final List<Favorite> favorites = await getFavorites();
    favorites.removeWhere((fav) => fav.id == id);
    await _saveFavorites(favorites);
  }

  Future<void> _saveFavorites(List<Favorite> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final String favoritesString = json.encode(
      favorites.map((fav) => fav.toMap()).toList(),
    );
    await prefs.setString(_favoritesKey, favoritesString);
  }

  // History
  static const String _historyKey = 'history';

  Future<List<HistoryItem>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String historyString = prefs.getString(_historyKey) ?? '[]';
    final List<dynamic> historyJson = json.decode(historyString);
    return historyJson.map((json) => HistoryItem.fromMap(json)).toList();
  }

  Future<void> saveHistoryItem(HistoryItem historyItem) async {
    final List<HistoryItem> history = await getHistory();
    
    // Garder seulement les 50 derniers éléments
    if (history.length >= 50) {
      history.removeLast();
    }
    
    history.insert(0, historyItem);
    await _saveHistory(history);
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  Future<void> deleteHistoryItem(String id) async {
  final List<HistoryItem> history = await getHistory();
  history.removeWhere((item) => item.id == id);
  await _saveHistory(history);
}

Future<void> deleteFavorite(String id) async {
  final List<Favorite> favorites = await getFavorites();
  favorites.removeWhere((fav) => fav.id == id);
  await _saveFavorites(favorites);
}

Future<void> clearAllFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_favoritesKey);
}

Future<void> toggleFavorite(String id) async {
  final List<Favorite> favorites = await getFavorites();
  final favorite = favorites.firstWhere((fav) => fav.id == id);
  favorite.toggleFavorite();
  await _saveFavorites(favorites);
}

Future<void> updateFavorite(Favorite updatedFavorite) async {
  final List<Favorite> favorites = await getFavorites();
  final index = favorites.indexWhere((fav) => fav.id == updatedFavorite.id);
  if (index != -1) {
    favorites[index] = updatedFavorite;
    await _saveFavorites(favorites);
  }
}

  Future<void> _saveHistory(List<HistoryItem> history) async {
    final prefs = await SharedPreferences.getInstance();
    final String historyString = json.encode(
      history.map((item) => item.toMap()).toList(),
    );
    await prefs.setString(_historyKey, historyString);
  }

  // Settings
  static const String _settingsKey = 'settings';

  Future<Map<String, dynamic>> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final String settingsString = prefs.getString(_settingsKey) ?? '{}';
    return Map<String, dynamic>.from(json.decode(settingsString));
  }

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    final prefs = await SharedPreferences.getInstance();
    final String settingsString = json.encode(settings);
    await prefs.setString(_settingsKey, settingsString);
  }
}