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

  ServerFailure _fakeError() {
    return ServerFailure(message: "Fake error message");
  }

  DataResult<Comic> _fakeDataResult() {
    var count = 10;
    return DataResult<Comic>(
      code: 1,
      status: "status",
      copyright: "copyright",
      attributionText: "attributionText",
      attributionHTML: "attributionHTML",
      data: Data<Comic>(
        count: count,
        limit: 10,
        offset: 0,
        total: 10,
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
      test('load NetworkFailure when repository fails', () async {
        var expected = _fakeError();

        when(() => comicsRepository.getComicsResult(any(), any()))
            .thenAnswer((_) async => Left(expected));

        controller.addListener(() {
          var comics = controller.comics;
          print("callStatus $comics");
          expect(controller.comics, isNotNull);

          if (comics.isLoading()) {
            expect(controller.count, 0);
            expect(controller.comics, isA<Loading>());
          }
          if (comics.isSuccess()) {
            fail("must not be a Success");
          }
          if (comics.isError()) {
            expect(controller.comics, isA<Error>());
            expect((controller.comics as Error).failure, isA<ServerFailure>());
            expect(
              (controller.comics as Error).failure.message,
              equals(expected.message),
            );
            expect(controller.total, 0);
            expect(controller.count, 0);
          }
        });

        await controller.loadComicsResult();
      });

      test('load list of Comic when repository success', () async {
        var expected = _fakeDataResult();

        when(() => comicsRepository.getComicsResult(any(), any()))
            .thenAnswer((_) async => Right(expected));

        controller.addListener(() {
          var comics = controller.comics;
          print("callStatus $comics");
          expect(controller.comics, isNotNull);

          if (comics.isLoading()) {
            expect(controller.count, 0);
            expect(controller.comics, isA<Loading>());
          }
          if (comics.isSuccess()) {
            var comics = controller.comics;
            expect(comics, isA<Success>());
            expect((comics as Success).data, isA<List>());
            expect((comics.data as List<Comic>).length,
                expected.data.results.length);
            expect(controller.total, expected.data.total);
            expect(
                controller.count, expected.data.offset + expected.data.count);
          }
          if (comics.isError()) {
            fail("must not be an Error");
          }
        });

        await controller.loadComicsResult();
      });
    });

    group('getMore', () {
      test('load NetworkFailure when repository fails', () async {
        var expected = _fakeError();

        when(() => comicsRepository.getComicsResult(any(), any()))
            .thenAnswer((_) async => Left(expected));

        controller.addListener(() {
          var comics = controller.comics;
          print("callStatus $comics");
          expect(controller.comics, isNotNull);

          if (comics.isLoading()) {
            expect(controller.count, 0);
            expect(controller.comics, isA<Loading>());
          }
          if (comics.isSuccess()) {
            fail("must not be a Success");
          }
          if (comics.isError()) {
            expect(controller.comics, isA<Error>());
            expect((controller.comics as Error).failure, isA<ServerFailure>());
            expect(
              (controller.comics as Error).failure.message,
              equals(expected.message),
            );
            expect(controller.total, 0);
            expect(controller.count, 0);
          }
        });

        await controller.getMore();
      });

      test('load list of Comic when repository success', () async {
        var expected = _fakeDataResult();

        when(() => comicsRepository.getComicsResult(any(), any()))
            .thenAnswer((_) async => Right(expected));

        controller.addListener(() {
          var comics = controller.comics;
          print("callStatus $comics");
          expect(controller.comics, isNotNull);

          if (comics.isLoading()) {
            expect(controller.count, 0);
            expect(controller.comics, isA<Loading>());
          }
          if (comics.isSuccess()) {
            expect(comics, isA<Success>());
            expect((comics as Success).data, isA<List>());
            expect((comics.data as List<Comic>).length,
                expected.data.results.length);
            expect(
                controller.count, expected.data.offset + expected.data.count);
          }
          if (comics.isError()) {
            fail("must not be an Error");
          }
        });

        await controller.getMore();
      });
    });
  });
}
