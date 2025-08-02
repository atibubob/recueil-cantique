class Cantique {
  int? id;
  String titre;
  String contenu;
  bool isFavori;

  Cantique({this.id, required this.titre, required this.contenu, this.isFavori = false});

  factory Cantique.fromMap(Map<String, dynamic> map) => Cantique(
        id: map['id'],
        titre: map['titre'],
        contenu: map['contenu'],
        isFavori: map['isFavori'] == 1,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'titre': titre,
        'contenu': contenu,
        'isFavori': isFavori ? 1 : 0,
      };
}
