class TransactionModel {
  final String id;
  final String gameId;
  final String package;
  final String userGameId;
  final String status;

  TransactionModel({
    required this.id,
    required this.gameId,
    required this.package,
    required this.userGameId,
    required this.status,
  });

  factory TransactionModel.fromFirestore(
    String id, Map<String, dynamic> data) {
      return TransactionModel(
        id:id,
        gameId: data['gameId'] ?? '',
        package: data['package'] ?? '',
        userGameId: data['userGameId'] ?? '',
        status: data['status'] ?? '',
      );
    }
}