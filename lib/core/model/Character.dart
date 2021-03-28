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
  final CharacterThumbnail thumbnail;
}

class CharacterUrl {
  const CharacterUrl({
    required this.type,
    required this.url,
  });

  final String type;
  final String url;
}

class CharacterThumbnail {
  const CharacterThumbnail({
    required this.path,
    required this.extension,
  });

  final String path;
  final String extension;
}
