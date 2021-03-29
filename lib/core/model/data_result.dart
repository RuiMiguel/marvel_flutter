class DataResult<T> {
  const DataResult({
    required this.code,
    required this.status,
    required this.copyright,
    required this.attributionText,
    required this.attributionHTML,
    required this.data,
    required this.etag,
  });

  final int code;
  final String status;
  final String copyright;
  final String attributionText;
  final String attributionHTML;
  final Data<T> data;
  final String etag;
}

class Data<T> {
  const Data({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<T> results;
}

class Thumbnail {
  const Thumbnail({
    required this.path,
    required this.extension,
  });

  final String path;
  final String extension;
}
