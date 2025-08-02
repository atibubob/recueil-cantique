import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/cantique.dart';
import 'cantique_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoris')),
      body: FutureBuilder<List<Cantique>>(
        future: DatabaseHelper.instance.getFavoris(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final favoris = snapshot.data!;
          if (favoris.isEmpty) return const Center(child: Text("Aucun cantique favori"));
          return ListView.builder(
            itemCount: favoris.length,
            itemBuilder: (context, index) {
              final cantique = favoris[index];
              return ListTile(
                title: Text(cantique.titre),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CantiqueDetailPage(cantique: cantique)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
