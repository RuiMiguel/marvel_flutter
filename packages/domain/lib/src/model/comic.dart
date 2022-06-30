import 'package:domain/src/model/model.dart';

class Comic {
  const Comic({
    required this.id,
    required this.digitalId,
    required this.title,
    required this.issueNumber,
    required this.variantDescription,
    required this.description,
    required this.modified,
    required this.isbn,
    required this.upc,
    required this.diamondCode,
    required this.ean,
    required this.issn,
    required this.format,
    required this.pageCount,
    required this.textObjects,
    required this.resourceURI,
    required this.urls,
    required this.prices,
    required this.thumbnail,
    required this.images,
  });

  final int id;
  final int digitalId;
  final String title;
  final double issueNumber;
  final String variantDescription;
  final String description;
  final String modified;
  final String isbn;
  final String upc;
  final String diamondCode;
  final String ean;
  final String issn;
  final String format;
  final int pageCount;
  final List<TextObject> textObjects;
  final String resourceURI;
  final List<ComicUrl> urls;
  final List<Price> prices;
  final Thumbnail thumbnail;
  final List<ComicImage> images;
}

class TextObject {
  const TextObject({
    required this.type,
    required this.language,
    required this.text,
  });

  final String type;
  final String language;
  final String text;
}

class ComicUrl {
  const ComicUrl({
    required this.type,
    required this.url,
  });

  final String type;
  final String url;
}

class Price {
  const Price({
    required this.type,
    required this.price,
  });

  final String type;
  final double price;
}

class ComicImage {
  const ComicImage({
    required this.path,
    required this.extension,
  });

  final String path;
  final String extension;
}
