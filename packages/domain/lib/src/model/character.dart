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
}

class CharacterUrl {
  const CharacterUrl({
    required this.type,
    required this.url,
  });

  final String type;
  final String url;
}
