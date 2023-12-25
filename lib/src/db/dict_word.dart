class DictWord {
  final int id;
  final String original;
  final String translation;

  const DictWord({
    required this.id,
    required this.original,
    required this.translation,
  });

  Map<String, dynamic> toMap() {
    return {
      'original': original,
      'translation': translation,
    };
  }

  @override
  String toString() {
    return 'DictWord{id: $id, original: $original, translation: $translation}';
  }
}
