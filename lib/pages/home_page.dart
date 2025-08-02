import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/cantique.dart';
import 'cantique_detail_page.dart';
import 'favorites_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Cantique> cantiques = [];

  @override
  void initState() {
    super.initState();
    _loadCantiques();
  }

  Future<void> _loadCantiques() async {
    final data = await DatabaseHelper.instance.getAllCantiques();
    setState(() {
      cantiques = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'REQUEIL ',
          style: TextStyle(
              color: Color.fromARGB(255, 3, 131, 235),
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'casual'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Color.fromARGB(255, 0, 0, 0),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const SearchPage())),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Color.fromARGB(228, 248, 3, 3),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const FavoritesPage())),
          ),
          IconButton(
              icon: const Icon(Icons.settings),
              color: Color.fromARGB(255, 0, 0, 0),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Parametre')),
                );
              }
              //() => Navigator.push(context,
              //MaterialPageRoute(builder: (_) => const FavoritesPage())),
              ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // hauteur de la ligne
          child: Container(
            color: const Color.fromARGB(48, 94, 90, 90), // couleur de la ligne
            height: 1.0,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: cantiques.length,
        itemBuilder: (context, index) {
          final cantique = cantiques[index];
          return Column(
            children: [
              ListTile(
                title: Text(cantique.titre,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Liloba na nzambe'),
                trailing: Icon(Icons.arrow_forward),
                leading: Icon(Icons.book),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CantiqueDetailPage(cantique: cantique)),
                  );
                },
              ),
              Divider(color: const Color.fromARGB(19, 158, 158, 158)),
            ],
          );
        },
      ),
    );
  }
}
