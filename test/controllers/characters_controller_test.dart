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

  ServerFailure _fakeServerFailure(String msg) {
    return ServerFailure(message: msg);
  }

  DataResult<Character> _fakeDataResult(
      {required int count,
      required int limit,
      required int offset,
      required int total}) {
    return DataResult<Character>(
      code: 1,
      status: "status",
      copyright: "copyright",
      attributionText: "attributionText",
      attributionHTML: "attributionHTML",
      data: Data<Character>(
        count: count,
        limit: limit,
        offset: offset,
        total: total,
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
      test('loading status before repository response', () async {
        var expected = _fakeServerFailure("Fake error message");

        when(() => charactersRepository.getCharactersResult(any(), any()))
            .thenAnswer((_) async => Left(expected));

        var callStatus = 0;

        controller.addListener(() {
          var characters = controller.characters;
          print("callStatus $characters");

          expect(characters, isNotNull);
          if (callStatus == 0) {
            expect(characters is Loading, isTrue);
          }
          if (callStatus == 1) {
            expect(characters is Error, isTrue);
          }

          callStatus++;
        });

        await controller.loadCharactersResult();
      });

      test('return NetworkFailure when repository fails', () async {
        var expected = _fakeServerFailure("Fake error message");

        when(() => charactersRepository.getCharactersResult(any(), any()))
            .thenAnswer((_) async => Left(expected));

        expect(controller.count, 0);

        await controller.loadCharactersResult();

        var characters = controller.characters;
        expect(characters, isNotNull);
        expect(characters, isA<Error>());
        expect((characters as Error).failure, isA<ServerFailure>());
        expect(characters.failure.message, equals(expected.message));
        expect(controller.total, 0);
        expect(controller.count, 0);
      });

      test('return list of Character when repository success', () async {
        var expected =
            _fakeDataResult(count: 10, limit: 10, offset: 0, total: 10);

        when(() => charactersRepository.getCharactersResult(any(), any()))
            .thenAnswer((_) async => Right(expected));

        expect(controller.count, 0);

        await controller.loadCharactersResult();

        var characters = controller.characters;
        expect(characters, isA<Success>());
        expect((characters as Success).data, isA<List>());
        expect((characters.data as List<Character>).length,
            expected.data.results.length);
        expect(controller.total, expected.data.total);
        expect(controller.count, expected.data.offset + expected.data.count);
      });
    });

    group('getMore', () {
      test('loading status before repository response', () async {
        var expected = _fakeServerFailure("Fake error message");

        when(() => charactersRepository.getCharactersResult(any(), any()))
            .thenAnswer((_) async => Left(expected));

        var callStatus = 0;

        controller.addListener(() {
          var characters = controller.characters;
          print("callStatus $characters");

          expect(characters, isNotNull);
          expect((callStatus == 0 && characters is Loading), isTrue);
          expect((callStatus == 1 && characters is Error), isTrue);

          callStatus++;
        });

        await controller.getMore();
      });

      test('return NetworkFailure when repository fails', () async {
        var expected = _fakeServerFailure("Fake error message");

        when(() => charactersRepository.getCharactersResult(any(), any()))
            .thenAnswer((_) async => Left(expected));

        expect(controller.count, 0);

        await controller.getMore();

        var characters = controller.characters;
        expect(characters, isA<Error>());
        expect((characters as Error).failure, isA<ServerFailure>());
        expect(characters.failure.message, equals(expected.message));
        expect(controller.total, 0);
        expect(controller.count, 0);
      });

      test('return list of Character when repository success', () async {
        var expected =
            _fakeDataResult(count: 10, limit: 10, offset: 0, total: 10);

        when(() => charactersRepository.getCharactersResult(any(), any()))
            .thenAnswer((_) async => Right(expected));

        expect(controller.count, 0);

        await controller.getMore();

        var characters = controller.characters;
        expect(characters, isA<Success>());
        expect((characters as Success).data, isA<List>());
        expect((characters.data as List<Character>).length,
            expected.data.results.length);
        expect(controller.count, expected.data.offset + expected.data.count);
      });
    });
  });
}
