import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/game_service.dart';
import '../../models/game_model.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameService = GameService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('R E - T O P U P'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: (){
              context.go('/history');
            })
        ],
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

          if (games.isEmpty) {
            return const Center(child: Text('No games available'));
          }

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
            
            return GestureDetector(
              onTap: () {
                context.go('/details', extra: game);
              },

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(game.name, style: const TextStyle(
                      fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      game.category,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              )
              );
            },
          );
        },
      ),
    );
  }
}