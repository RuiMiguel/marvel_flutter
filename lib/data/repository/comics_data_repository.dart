import 'package:core_domain/core_domain.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel/data/mapper/data2domain_mapper.dart';
import 'package:marvel/data/service/comic_api_client.dart';
import 'package:marvel_domain/marvel_domain.dart';

class ComicsDataRepository extends ComicsRepository {
  final ComicsApiClient _comicApiClient;

  ComicsDataRepository(this._comicApiClient);

  @override
  Future<Either<Failure, DataResult<Comic>>> getComicsResult(
    int limit,
    int offset,
  ) async {
    final apiResult = await _comicApiClient.getComicsResult(limit, offset);
    return apiResult.fold(
      (error) => Left(error),
      (success) => Right(success.toResultComic()),
    );
  }
}
