import 'package:flutter/material.dart';
import '../../services/transaction_service.dart';
import '../../models/transaction_model.dart';

class HistoryPage extends StatelessWidget{
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = TransactionService();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
      ),
      body: FutureBuilder<List<TransactionModel>>(
        future: service.getUserTransactons(),
        builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
           if (snapshot.hasError) {
                  return const Text('Error Load Data');
                }
        final transaction = snapshot.data ?? [];

        if (transaction.isEmpty) {
          return const Center(child: Text('Belum Ada Transaksi'));
        }

        return ListView.builder(
          itemCount: transaction.length,
          itemBuilder: (context, index) {
            final trx = transaction[index];

            return ListTile(
              title: Text(trx.package),
              subtitle: Text("User ID: ${trx.userGameId}"),
              trailing: Text(trx.status),
            );
          },
        );
        },
      )
    );
  }
}