import 'package:core_data_network/core_data_network.dart';
import 'package:core_domain/core_domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/controllers/characters_controller.dart';
import 'package:marvel_domain/marvel_domain.dart';
import 'package:mocktail/mocktail.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  var charactersRepository = MockCharactersRepository();
  late CharactersController controller;

  void _initController() {
    controller =
        CharactersController(charactersRepository = MockCharactersRepository());
  }

  ServerFailure _fakeError() {
    return ServerFailure(message: "Fake error message");
  }

  DataResult<Character> _fakeDataResult() {
    var count = 10;
    return DataResult<Character>(
      code: 1,
      status: "status",
      copyright: "copyright",
      attributionText: "attributionText",
      attributionHTML: "attributionHTML",
      data: Data<Character>(
        count: count,
        limit: 10,
        offset: 0,
        total: 10,
        results: List.generate(
          count,
          (index) => Character(
            id: index,
            name: "name",
            description: "description",
            modified: "modified",
            resourceURI: "resourceURI",
            urls: List.empty(),
            thumbnail: Thumbnail(path: "path", extension: "extension"),
          ),
        ),
      ),
      etag: "etag",
    );
  }

  group('CharactersController', () {
    setUp(() {
      _initController();
    });

    group('loadCharactersResult', () {
      test('load NetworkFailure when repository fails', () async {
        var expected = _fakeError();

        when(() => charactersRepository.getCharactersResult(any(), any()))
            .thenAnswer((_) async => Left(expected));

        controller.addListener(() {
          var characters = controller.characters;
          print("callStatus $characters");

          expect(controller.characters, isNotNull);

          if (characters.isLoading()) {
            expect(controller.count, 0);
            expect(controller.characters, isA<Loading>());
          }
          if (characters.isSuccess()) {
            fail("must not be a Success");
          }
          if (characters.isError()) {
            expect(controller.characters, isNotNull);
            expect(controller.characters, isA<Error>());
            expect(
                (controller.characters as Error).failure, isA<ServerFailure>());
            expect(
              (controller.characters as Error).failure.message,
              equals(expected.message),
            );
            expect(controller.total, 0);
            expect(controller.count, 0);
          }
        });

        await controller.loadCharactersResult();
      });

      test('load list of Character when repository success', () async {
        var expected = _fakeDataResult();

        when(() => charactersRepository.getCharactersResult(any(), any()))
            .thenAnswer((_) async => Right(expected));

        controller.addListener(() {
          var characters = controller.characters;
          print("callStatus $characters");
          expect(characters, isNotNull);

          if (characters.isLoading()) {
            expect(controller.count, 0);
            expect(controller.characters, isNotNull);
            expect(controller.characters, isA<Loading>());
          }
          if (characters.isSuccess()) {
            expect(characters, isA<Success>());
            expect((characters as Success).data, isA<List>());
            expect((characters.data as List<Character>).length,
                expected.data.results.length);
            expect(controller.total, expected.data.total);
            expect(
                controller.count, expected.data.offset + expected.data.count);
          }
          if (characters.isError()) {
            fail("must not be an Error");
          }
        });

        await controller.loadCharactersResult();
      });
    });

    group('getMore', () {
      test('load NetworkFailure when repository fails', () async {
        var expected = _fakeError();

        when(() => charactersRepository.getCharactersResult(any(), any()))
            .thenAnswer((_) async => Left(expected));

        controller.addListener(() {
          var characters = controller.characters;
          print("callStatus $characters");

          expect(characters, isNotNull);

          if (characters.isLoading()) {
            expect(controller.count, 0);
            expect(characters, isA<Loading>());
          }
          if (characters.isSuccess()) {
            fail("must not be a Success");
          }
          if (characters.isError()) {
            expect(controller.characters, isA<Error>());
            expect(
                (controller.characters as Error).failure, isA<ServerFailure>());
            expect(
              (controller.characters as Error).failure.message,
              equals(expected.message),
            );
            expect(controller.total, 0);
            expect(controller.count, 0);
          }
        });

        await controller.getMore();
      });

      test('load list of Character when repository success', () async {
        var expected = _fakeDataResult();

        when(() => charactersRepository.getCharactersResult(any(), any()))
            .thenAnswer((_) async => Right(expected));

        controller.addListener(() {
          var characters = controller.characters;
          print("callStatus $characters");
          expect(controller.characters, isNotNull);

          if (characters.isLoading()) {
            expect(controller.count, 0);
            expect(controller.characters, isA<Loading>());
          }
          if (characters.isSuccess()) {
            expect(characters, isA<Success>());
            expect((characters as Success).data, isA<List>());
            expect((characters.data as List<Character>).length,
                expected.data.results.length);
            expect(
                controller.count, expected.data.offset + expected.data.count);
          }
          if (characters.isError()) {
            fail("must not be an Error");
          }
        });

        await controller.getMore();
      });
    });
  });
}
