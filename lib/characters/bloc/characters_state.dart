part of 'characters_bloc.dart';

enum CharactersStatus { initial, loading, success, error }

extension CharactersStatusX on CharactersStatus {
  bool get isInitial => this == CharactersStatus.initial;
  bool get isLoading => this == CharactersStatus.loading;
  bool get isSuccess => this == CharactersStatus.success;
  bool get isError => this == CharactersStatus.error;
}

class CharactersState extends Equatable {
  const CharactersState({
    this.status = CharactersStatus.initial,
    required this.characters,
    required this.count,
    required this.total,
    required this.offset,
    required this.legal,
  });

  const CharactersState.initial()
      : status = CharactersStatus.initial,
        characters = const [],
        count = 0,
        total = 0,
        offset = 0,
        legal = '';

  final CharactersStatus status;
  final List<Character> characters;
  final int count;
  final int total;
  final int offset;
  final String legal;

  @override
  List<Object> get props => [status, characters, count, total, offset, legal];

  CharactersState copyWith({
    CharactersStatus? status,
    List<Character>? characters,
    int? count,
    int? total,
    int? offset,
    String? legal,
  }) {
    return CharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      count: count ?? this.count,
      total: total ?? this.total,
      offset: offset ?? this.offset,
      legal: legal ?? this.legal,
    );
  }
}
