import 'package:flutter/material.dart';
import '../models/cantique.dart';
import '../db/database_helper.dart';
import 'cantique_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Cantique> searchResults = [];

  void _search(String query) async {
    final results = await DatabaseHelper.instance.searchCantiques(query);
    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recherche')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Titre du cantique',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onChanged: _search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final cantique = searchResults[index];
                return ListTile(
                  title: Text(cantique.titre),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CantiqueDetailPage(cantique: cantique)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
