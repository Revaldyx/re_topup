import 'dart:ffi';

class TopupPackage {
  final String id;
  final String gameId;
  final String name;
  final Int price; 

  TopupPackage({
    required this.id,
    required this.gameId,
    required this.name,
    required this.price,
  });

  factory TopupPackage.fromFirestore(
      String id, Map<String, dynamic> data) {
    return TopupPackage(
      id: id,
      gameId: data['gameId'] ?? '',
      name: data['name'] ?? '',
      price: data['price'] ?? 0 as Int,
    );
  }
}