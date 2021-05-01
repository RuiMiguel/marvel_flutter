import 'package:core_data_network/core_data_network.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_data/src/model/api_comic.dart';
import 'package:marvel_data/src/model/api_result.dart';
import 'package:marvel_data/src/repository/comics_data_repository.dart';
import 'package:marvel_data/src/service/comic_api_client.dart';
import 'package:marvel_domain/marvel_domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../utils/either.dart';

import 'comics_data_repository_test.mocks.dart';

@GenerateMocks([ComicsApiClient])
void main() {
  var comicsApiClient = MockComicsApiClient();
  late ComicsDataRepository comicsDataRepository;

  group('ComicsDataRepository', () {
    setUp(() {
      comicsDataRepository = ComicsDataRepository(comicsApiClient);
    });

    group('getComicsResult', () {
      test('returns NetworkFailure when apiclient fails', () async {
        int _limit = 100;
        int _offset = 50;
        Either<NetworkFailure, ApiResult<ApiComic>> expected =
            Left(ServerFailure());

        when(comicsApiClient.getComicsResult(any, any))
            .thenAnswer((_) async => expected);

        var either =
            await comicsDataRepository.getComicsResult(_limit, _offset);

        expect(either, isA<Either>());
        expect(either, isNotNull);
        var left = either.l();
        expect(left, isA<NetworkFailure>());
      });

      test('returns successfull DataResult when apiclient returns ApiResult',
          () async {
        int _limit = 100;
        int _offset = 50;
        Either<NetworkFailure, ApiResult<ApiComic>> expected =
            Right(ApiResult());

        when(comicsApiClient.getComicsResult(any, any))
            .thenAnswer((_) async => expected);

        var either =
            await comicsDataRepository.getComicsResult(_limit, _offset);

        expect(either, isA<Either>());
        expect(either, isNotNull);
        var right = either.r();
        expect(right, isA<DataResult>());
      });
    });
  });
}
