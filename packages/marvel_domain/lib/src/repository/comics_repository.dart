import 'package:core_domain/core_domain.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel_domain/marvel_domain.dart';

abstract class ComicsRepository {
  Future<Either<Failure, DataResult<Comic>>> getComicsResult(
    int limit,
    int offset,
  );
}
