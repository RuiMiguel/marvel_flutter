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

  Comic copyWith({
    int? id,
    int? digitalId,
    String? title,
    double? issueNumber,
    String? variantDescription,
    String? description,
    String? modified,
    String? isbn,
    String? upc,
    String? diamondCode,
    String? ean,
    String? issn,
    String? format,
    int? pageCount,
    List<TextObject>? textObjects,
    String? resourceURI,
    List<ComicUrl>? urls,
    List<Price>? prices,
    Thumbnail? thumbnail,
    List<ComicImage>? images,
  }) {
    return Comic(
      id: id ?? this.id,
      digitalId: digitalId ?? this.digitalId,
      title: title ?? this.title,
      issueNumber: issueNumber ?? this.issueNumber,
      variantDescription: variantDescription ?? this.variantDescription,
      description: description ?? this.description,
      modified: modified ?? this.modified,
      isbn: isbn ?? this.isbn,
      upc: upc ?? this.upc,
      diamondCode: diamondCode ?? this.diamondCode,
      ean: ean ?? this.ean,
      issn: issn ?? this.issn,
      format: format ?? this.format,
      pageCount: pageCount ?? this.pageCount,
      textObjects: textObjects ?? this.textObjects,
      resourceURI: resourceURI ?? this.resourceURI,
      urls: urls ?? this.urls,
      prices: prices ?? this.prices,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
    );
  }
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

extension ComicImageX on ComicImage {
  String get comicDetailGalleryPreview => '$path/portrait_fantastic.$extension';
}
