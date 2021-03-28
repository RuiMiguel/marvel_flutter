// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_comic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiComic _$ApiComicFromJson(Map<String, dynamic> json) {
  return ApiComic(
    id: json['id'] as String,
    digitalId: json['digitalId'] as String,
    title: json['title'] as String,
    issueNumber: json['issueNumber'] as String,
    variantDescription: json['variantDescription'] as String,
    description: json['description'] as String,
    modified: json['modified'] as String,
    isbn: json['isbn'] as String,
    upc: json['upc'] as String,
    diamondCode: json['diamondCode'] as String,
    ean: json['ean'] as String,
    issn: json['issn'] as String,
    format: json['format'] as String,
    pageCount: json['pageCount'] as String,
    textObjects: (json['textObjects'] as List<dynamic>)
        .map((e) => ApiTextObject.fromJson(e as Map<String, dynamic>))
        .toList(),
    resourceURI: json['resourceURI'] as String,
    urls: (json['urls'] as List<dynamic>)
        .map((e) => ApiUrl.fromJson(e as Map<String, dynamic>))
        .toList(),
    prices: (json['prices'] as List<dynamic>)
        .map((e) => ApiPrice.fromJson(e as Map<String, dynamic>))
        .toList(),
    thumbnail: ApiThumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
    images: (json['images'] as List<dynamic>)
        .map((e) => ApiImage.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ApiComicToJson(ApiComic instance) => <String, dynamic>{
      'id': instance.id,
      'digitalId': instance.digitalId,
      'title': instance.title,
      'issueNumber': instance.issueNumber,
      'variantDescription': instance.variantDescription,
      'description': instance.description,
      'modified': instance.modified,
      'isbn': instance.isbn,
      'upc': instance.upc,
      'diamondCode': instance.diamondCode,
      'ean': instance.ean,
      'issn': instance.issn,
      'format': instance.format,
      'pageCount': instance.pageCount,
      'textObjects': instance.textObjects,
      'resourceURI': instance.resourceURI,
      'urls': instance.urls,
      'prices': instance.prices,
      'thumbnail': instance.thumbnail,
      'images': instance.images,
    };

ApiTextObject _$ApiTextObjectsFromJson(Map<String, dynamic> json) {
  return ApiTextObject(
    type: json['type'] as String,
    language: json['language'] as String,
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$ApiTextObjectsToJson(ApiTextObject instance) =>
    <String, dynamic>{
      'type': instance.type,
      'language': instance.language,
      'text': instance.text,
    };

ApiUrl _$ApiUrlsFromJson(Map<String, dynamic> json) {
  return ApiUrl(
    type: json['type'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$ApiUrlsToJson(ApiUrl instance) => <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
    };

ApiPrice _$ApiPricesFromJson(Map<String, dynamic> json) {
  return ApiPrice(
    type: json['type'] as String,
    price: json['price'] as String,
  );
}

Map<String, dynamic> _$ApiPricesToJson(ApiPrice instance) => <String, dynamic>{
      'type': instance.type,
      'price': instance.price,
    };

ApiImage _$ApiImagesFromJson(Map<String, dynamic> json) {
  return ApiImage(
    path: json['path'] as String,
    extension: json['extension'] as String,
  );
}

Map<String, dynamic> _$ApiImagesToJson(ApiImage instance) => <String, dynamic>{
      'path': instance.path,
      'extension': instance.extension,
    };
