import 'package:marvel/core/model/character.dart';
import 'package:marvel/data/model/api_character.dart';

extension CharactersMapper on List<ApiCharacter> {
  List<Character> toCharacters() {
    return map((element) {
      return element.toCharacter();
    }).toList();
  }
}

extension CharacterMapper on ApiCharacter {
  Character toCharacter() {
    return new Character(
      id: id,
      name: name,
      description: description,
      modified: modified,
      resourceURI: resourceURI,
      urls: urls.toCharactersUrl(),
      thumbnail: thumbnail.toCharacterThumbnail(),
    );
  }
}

extension CharactersUrlMapper on List<ApiCharacterUrl> {
  List<CharacterUrl> toCharactersUrl() {
    return map((element) => element.toCharacterUrl()).toList();
  }
}

extension CharacterUrlMapper on ApiCharacterUrl {
  CharacterUrl toCharacterUrl() {
    return new CharacterUrl(
      type: type,
      url: url,
    );
  }
}

extension CharacterThumbnailMapper on ApiCharacterThumbnail {
  CharacterThumbnail toCharacterThumbnail() {
    return new CharacterThumbnail(
      path: path,
      extension: extension,
    );
  }
}
