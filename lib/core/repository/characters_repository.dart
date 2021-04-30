import 'package:core_domain/core_domain.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel/core/model/character.dart';
import 'package:marvel/core/model/data_result.dart';

abstract class CharactersRepository {
  Future<Either<Failure, DataResult<Character>>> getCharactersResult(
    int limit,
    int offset,
  );
}
