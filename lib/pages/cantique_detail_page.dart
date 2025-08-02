//import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';
import 'package:flutter/material.dart';
import '../models/cantique.dart';
import '../db/database_helper.dart';

class CantiqueDetailPage extends StatefulWidget {
  final Cantique cantique;
  const CantiqueDetailPage({super.key, required this.cantique});

  @override
  State<CantiqueDetailPage> createState() => _CantiqueDetailPageState();
}

class _CantiqueDetailPageState extends State<CantiqueDetailPage> {
  double zoom = 20;
  void _zoomplus() {
    if (zoom == 40) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Taille maximum atein')),
      );
    } else {
      setState(() {
        zoom++;
      });
    }
  }

  void _zoomMoins() {
    if (zoom == 20) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Taille minimum atein')),
      );
    } else {
      setState(() {
        zoom--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.cantique.titre,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(widget.cantique.isFavori
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Color.fromARGB(228, 248, 3, 3),
              onPressed: () async {
                setState(() {
                  widget.cantique.isFavori = !widget.cantique.isFavori;
                });
                await DatabaseHelper.instance.updateCantique(widget.cantique);
              },
            ),
            IconButton(
              icon: Icon(
                  widget.cantique.isFavori ? Icons.zoom_in : Icons.zoom_in),
              onPressed: _zoomplus,
            ),
            IconButton(
                icon: Icon(
                    widget.cantique.isFavori ? Icons.zoom_out : Icons.zoom_out),
                onPressed: _zoomMoins)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cantique.titre,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.cantique.contenu,
                  style: TextStyle(fontSize: zoom),
                ),
              ],
            ),
          ),
        ));
  }
}
