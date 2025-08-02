import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/cantique.dart';

class ManageCantiquePage extends StatefulWidget {
  const ManageCantiquePage({super.key});

  @override
  State<ManageCantiquePage> createState() => _ManageCantiquePageState();
}

class _ManageCantiquePageState extends State<ManageCantiquePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _contenuController = TextEditingController();

  Future<void> _enregistrerCantique() async {
    if (_formKey.currentState!.validate()) {
      final newCantique = Cantique(
        titre: _titreController.text,
        contenu: _contenuController.text,
        isFavori: false,
      );
      final db = DatabaseHelper.instance;
      final database = await db.database;
      await database.insert('cantiques', newCantique.toMap());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cantique ajouté avec succès')),
      );
      _titreController.clear();
      _contenuController.clear();
    }
  }

  @override
  void dispose() {
    _titreController.dispose();
    _contenuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un Cantique')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titreController,
                decoration: const InputDecoration(labelText: 'Titre'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Entrez un titre'
                            : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contenuController,
                decoration: const InputDecoration(labelText: 'Contenu'),
                maxLines: 5,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Entrez le contenu'
                            : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Enregistrer'),
                onPressed: _enregistrerCantique,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
