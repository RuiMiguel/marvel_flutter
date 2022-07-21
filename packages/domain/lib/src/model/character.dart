import 'package:domain/src/model/model.dart';

class Character {
  const Character({
    required this.id,
    required this.name,
    required this.description,
    required this.modified,
    required this.resourceURI,
    required this.urls,
    required this.thumbnail,
  });

  final int id;
  final String name;
  final String description;
  final String modified;
  final String resourceURI;
  final List<CharacterUrl> urls;
  final Thumbnail thumbnail;

  Character copyWith({
    int? id,
    String? name,
    String? description,
    String? modified,
    String? resourceURI,
    List<CharacterUrl>? urls,
    Thumbnail? thumbnail,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      modified: modified ?? this.modified,
      resourceURI: resourceURI ?? this.resourceURI,
      urls: urls ?? this.urls,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }
}

class CharacterUrl {
  const CharacterUrl({
    required this.type,
    required this.url,
  });

  final String type;
  final String url;
}
