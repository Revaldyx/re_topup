import 'package:flutter/material.dart';
import 'package:re_topup/models/topup_model.dart';
import 'package:re_topup/services/topup_services.dart';
import 'package:re_topup/services/transaction_service.dart';
import '../../models/game_model.dart';

class DetailPage extends StatefulWidget {
  final GameModel game;

  const DetailPage({super.key, required this.game});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final userIdController = TextEditingController();
  final transactionService = TransactionService();

  final topupService = TopupServices();
  
  TopupPackage? selectedPackage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: userIdController,
              decoration: const InputDecoration(
                labelText: 'User ID',
              ),
            ),

            const SizedBox(height: 20),

            FutureBuilder<List<TopupPackage>>(
              future: topupService.getPackages(widget.game.id),
              builder: (context, snapshot) {
                print("GAME ID: ${widget.game.id}");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Text('Error Load Package');
                }

                final packages = snapshot.data ?? [];

                return Wrap(
                  spacing: 10,
                  children: packages.map((item){
                    return ChoiceChip(
                      label: Text("${item.name} - Rp ${item.price}"), 
                      selected: selectedPackage?.id == item.id,
                      onSelected: (_) {
                        setState(() {
                          selectedPackage = item;
                        });
                      },
                      );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                if (selectedPackage == null ||
                    userIdController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Lengkapi Data")),
                  );
                  return;
                }

                await transactionService.createTransaction(
                  gameId: widget.game.id,
                  packageName: selectedPackage!.name,
                  userGameId: userIdController.text,
                );

                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Transaksi Berhasil')),
                );
              },
              child: const Text('Beli'),
            ),
          ],
        ),
      ),
    );
  }
}