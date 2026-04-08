import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:re_topup/models/transaction_model.dart';

class TransactionService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> createTransaction({
    required String gameId,
    required String packageName,
    required String userGameId,
  }) async {
    final user = _auth.currentUser;

    await _db.collection('transaction').add({
      'userId': user?.uid,
      'gameId': gameId,
      'package': packageName,
      'userGameId': userGameId,
      'status': 'pending',
      'createAt': DateTime.now(),
    });
  }

  Future<List<TransactionModel>> getUserTransactons() async {
   final user = _auth.currentUser;

   final snapshot = await _db
    .collection('transaction')
    .where('userId', isEqualTo: user?.uid)
    .orderBy('createAt', descending: true)
    .get();

    return snapshot.docs.map((doc) {
      return TransactionModel.fromFirestore(doc.id, doc.data());
    }).toList();
  }
}