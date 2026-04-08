import 'package:flutter/material.dart';
import '../../services/game_service.dart';
import '../../models/game_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameService = GameService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TopUp App'),
      ),
      body: FutureBuilder<List<GameModel>>(
        future: gameService.getGames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading games'));
          }

          final games = snapshot.data ?? [];

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: games.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final game = games[index];

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: Center(
                  child: Text(game.name),
                ),
              );
            },
          );
        },
      ),
    );
  }
}