import 'package:core_domain/core_domain.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel_domain/marvel_domain.dart';
import 'package:marvel_domain/src/model/character.dart';

abstract class CharactersRepository {
  Future<Either<Failure, DataResult<Character>>> getCharactersResult(
    int limit,
    int offset,
  );
}
