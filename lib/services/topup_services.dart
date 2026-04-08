import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/topup_model.dart';

class TopupServices {
  final _db = FirebaseFirestore.instance;

  Future<List<TopupPackage>> getPackages(String gameId) async {
    final snapshot = await _db 
      .collection('topup_pkg')
      .where('gameId', isEqualTo: gameId)
      .get();

    return snapshot.docs.map((doc){
      return TopupPackage.fromFirestore(doc.id, doc.data());
    }).toList();
  }
}