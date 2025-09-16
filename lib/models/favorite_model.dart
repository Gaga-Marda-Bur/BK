class Favorite {
  final String id;
  final String content;
  final DateTime dateAdded;
  final String type; // 'word' or 'character'
  bool isFavorite; // État togglable

  Favorite({
    required this.id,
    required this.content,
    required this.dateAdded,
    required this.type,
    this.isFavorite = true, // Par défaut true
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'dateAdded': dateAdded.millisecondsSinceEpoch,
      'type': type,
      'isFavorite': isFavorite,
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'],
      content: map['content'],
      dateAdded: DateTime.fromMillisecondsSinceEpoch(map['dateAdded']),
      type: map['type'],
      isFavorite: map['isFavorite'] ?? true,
    );
  }

  // Méthode pour toggle l'état
  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}