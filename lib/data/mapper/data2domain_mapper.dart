import 'package:marvel/core/model/character.dart';
import 'package:marvel/core/model/result.dart';
import 'package:marvel/data/model/api_character.dart';
import 'package:marvel/data/model/api_result.dart';

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
      thumbnail: thumbnail.toThumbnail(),
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

extension ThumbnailMapper on ApiThumbnail {
  Thumbnail toThumbnail() {
    return new Thumbnail(
      path: path,
      extension: extension,
    );
  }
}
