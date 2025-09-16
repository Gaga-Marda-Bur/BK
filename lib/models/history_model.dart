class HistoryItem {
  final String id;
  final String text;
  final DateTime dateCreated;

  HistoryItem({
    required this.id,
    required this.text,
    required this.dateCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'dateCreated': dateCreated.millisecondsSinceEpoch,
    };
  }

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      id: map['id'],
      text: map['text'],
      dateCreated: DateTime.fromMillisecondsSinceEpoch(map['dateCreated']),
    );
  }
}