import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/game_model.dart';

class GameService {
  final _db = FirebaseFirestore.instance;

  Future<List<GameModel>> getGames() async {
    try {
      final snapshot = await _db.collection('games').get();
      
       return snapshot.docs
          .map((doc) {
            return GameModel.fromFirestore(doc.id, doc.data());
          }).toList();
          }
     catch (e) {
      print('Error fetching games: $e');
      return [];
    }
  }}