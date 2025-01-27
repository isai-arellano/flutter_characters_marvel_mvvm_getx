class Character {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? 'Sin descripción disponible.',
      imageUrl: "${json['thumbnail']['path']}.${json['thumbnail']['extension']}",
    );
  }
}