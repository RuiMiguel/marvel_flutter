// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_comic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiComic _$ApiComicFromJson(Map<String, dynamic> json) => ApiComic(
      id: json['id'] as int?,
      digitalId: json['digitalId'] as int?,
      title: json['title'] as String?,
      issueNumber: (json['issueNumber'] as num?)?.toDouble(),
      variantDescription: json['variantDescription'] as String?,
      description: json['description'] as String?,
      modified: json['modified'] as String?,
      isbn: json['isbn'] as String?,
      upc: json['upc'] as String?,
      diamondCode: json['diamondCode'] as String?,
      ean: json['ean'] as String?,
      issn: json['issn'] as String?,
      format: json['format'] as String?,
      pageCount: json['pageCount'] as int?,
      textObjects: (json['textObjects'] as List<dynamic>?)
          ?.map(
              (dynamic e) => ApiTextObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      resourceURI: json['resourceURI'] as String?,
      urls: (json['urls'] as List<dynamic>?)
          ?.map((dynamic e) => ApiComicUrl.fromJson(e as Map<String, dynamic>))
          .toList(),
      prices: (json['prices'] as List<dynamic>?)
          ?.map((dynamic e) => ApiPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
      thumbnail: json['thumbnail'] == null
          ? null
          : ApiThumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map(
              (dynamic e) => ApiComicImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

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

ApiTextObject _$ApiTextObjectFromJson(Map<String, dynamic> json) =>
    ApiTextObject(
      type: json['type'] as String?,
      language: json['language'] as String?,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$ApiTextObjectToJson(ApiTextObject instance) =>
    <String, dynamic>{
      'type': instance.type,
      'language': instance.language,
      'text': instance.text,
    };

ApiComicUrl _$ApiComicUrlFromJson(Map<String, dynamic> json) => ApiComicUrl(
      type: json['type'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ApiComicUrlToJson(ApiComicUrl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
    };

ApiPrice _$ApiPriceFromJson(Map<String, dynamic> json) => ApiPrice(
      type: json['type'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ApiPriceToJson(ApiPrice instance) => <String, dynamic>{
      'type': instance.type,
      'price': instance.price,
    };

ApiComicImage _$ApiComicImageFromJson(Map<String, dynamic> json) =>
    ApiComicImage(
      path: json['path'] as String?,
      extension: json['extension'] as String?,
    );

Map<String, dynamic> _$ApiComicImageToJson(ApiComicImage instance) =>
    <String, dynamic>{
      'path': instance.path,
      'extension': instance.extension,
    };
