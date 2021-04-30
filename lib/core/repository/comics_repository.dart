import 'package:core_domain/core_domain.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel/core/model/comic.dart';
import 'package:marvel/core/model/data_result.dart';

abstract class ComicsRepository {
  Future<Either<Failure, DataResult<Comic>>> getComicsResult(
    int limit,
    int offset,
  );
}
