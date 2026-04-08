class GameModel {
  final String id;
  final String name;
  final String image;
  final String category;

  GameModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
  });

  factory GameModel.fromFirestore(String id, Map<String, dynamic> data) {
    return GameModel(
      id: id,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      category: data['category'] ?? '',
    );
}
}