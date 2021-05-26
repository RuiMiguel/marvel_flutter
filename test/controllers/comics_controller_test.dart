import 'package:core_data_network/core_data_network.dart';
import 'package:core_domain/core_domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/controllers/comics_controller.dart';
import 'package:marvel_domain/marvel_domain.dart';
import 'package:mocktail/mocktail.dart';

class MockComicsRepository extends Mock implements ComicsRepository {}

void main() {
  var comicsRepository = MockComicsRepository();
  late ComicsController controller;

  void _initController() {
    controller = ComicsController(comicsRepository);
  }

  ServerFailure _fakeServerFailure(String msg) {
    return ServerFailure(message: msg);
  }

  DataResult<Comic> _fakeDataResult(
      {required int count,
      required int limit,
      required int offset,
      required int total}) {
    return DataResult<Comic>(
      code: 1,
      status: "status",
      copyright: "copyright",
      attributionText: "attributionText",
      attributionHTML: "attributionHTML",
      data: Data<Comic>(
        count: count,
        limit: limit,
        offset: offset,
        total: total,
        results: List.generate(
          count,
          (index) => Comic(
            id: index,
            digitalId: index,
            title: "title",
            issueNumber: index.toDouble(),
            variantDescription: "variantDescription",
            description: "description",
            modified: "modified",
            isbn: "isbn",
            upc: "upc",
            diamondCode: "diamondCode",
            ean: "ean",
            issn: "issn",
            format: "format",
            pageCount: index,
            textObjects: List.empty(),
            resourceURI: "resourceURI",
            urls: List.empty(),
            prices: List.empty(),
            thumbnail: Thumbnail(path: "path", extension: "extension"),
            images: List.empty(),
          ),
        ),
      ),
      etag: "etag",
    );
  }

  group('ComicsController', () {
    setUp(() {
      _initController();
    });

    group('loadComicsResult', () {
      test('loading status before repository response', () async {
        var expected = _fakeServerFailure("Fake error message");

        when(() => comicsRepository.getComicsResult(any(), any()))
            .thenAnswer((_) async => Left(expected));

        var callStatus = 0;

        controller.addListener(() {
          var comics = controller.comics;
          print("callStatus $comics");

          expect(comics, isNotNull);
          expect((callStatus == 0 && comics is Loading), isTrue);
          expect((callStatus == 1 && comics is Error), isTrue);

          callStatus++;
        });

        await controller.loadComicsResult();
      });

      test('return NetworkFailure when repository fails', () async {
        var expected = _fakeServerFailure("Fake error message");

        when(() => comicsRepository.getComicsResult(any(), any()))
            .thenAnswer((_) async => Left(expected));

        expect(controller.count, 0);

        await controller.loadComicsResult();

        var comics = controller.comics;
        expect(comics, isA<Error>());
        expect((comics as Error).failure, isA<ServerFailure>());
        expect(comics.failure.message, equals(expected.message));
        expect(controller.total, 0);
        expect(controller.count, 0);
      });

      test('return list of Comic when repository success', () async {
        var expected =
            _fakeDataResult(count: 10, limit: 10, offset: 0, total: 10);

        when(() => comicsRepository.getComicsResult(any(), any()))
            .thenAnswer((_) async => Right(expected));

        expect(controller.count, 0);

        await controller.loadComicsResult();

        var comics = controller.comics;
        expect(comics, isA<Success>());
        expect((comics as Success).data, isA<List>());
        expect(
            (comics.data as List<Comic>).length, expected.data.results.length);
        expect(controller.total, expected.data.total);
        expect(controller.count, expected.data.offset + expected.data.count);
      });
    });

    group('getMore', () {
      test('loading status before repository response', () async {
        var expected = _fakeServerFailure("Fake error message");

        when(() => comicsRepository.getComicsResult(any(), any()))
            .thenAnswer((_) async => Left(expected));

        var callStatus = 0;

        controller.addListener(() {
          var comics = controller.comics;
          print("callStatus $comics");

          expect(comics, isNotNull);
          if (callStatus == 0) {
            expect(comics is Loading, isTrue);
          }
          if (callStatus == 1) {
            expect(comics is Error, isTrue);
          }

          callStatus++;
        });

        await controller.getMore();
      });

      test('return NetworkFailure when repository fails', () async {
        var expected = _fakeServerFailure("Fake error message");

        when(() => comicsRepository.getComicsResult(any(), any()))
            .thenAnswer((_) async => Left(expected));

        expect(controller.count, 0);

        await controller.getMore();

        var comics = controller.comics;
        expect(comics, isA<Error>());
        expect((comics as Error).failure, isA<ServerFailure>());
        expect(comics.failure.message, equals(expected.message));
        expect(controller.total, 0);
        expect(controller.count, 0);
      });

      test('return list of Comic when repository success', () async {
        var expected =
            _fakeDataResult(count: 10, limit: 10, offset: 0, total: 10);

        when(() => comicsRepository.getComicsResult(any(), any()))
            .thenAnswer((_) async => Right(expected));

        expect(controller.count, 0);

        await controller.getMore();

        var comics = controller.comics;
        expect(comics, isA<Success>());
        expect((comics as Success).data, isA<List>());
        expect(
            (comics.data as List<Comic>).length, expected.data.results.length);
        expect(controller.count, expected.data.offset + expected.data.count);
      });
    });
  });
}
