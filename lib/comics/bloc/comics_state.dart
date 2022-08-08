part of 'comics_bloc.dart';

enum ComicsStatus { initial, loading, success, error }

extension ComicsStatusX on ComicsStatus {
  bool get isInitial => this == ComicsStatus.initial;
  bool get isLoading => this == ComicsStatus.loading;
  bool get isSuccess => this == ComicsStatus.success;
  bool get isError => this == ComicsStatus.error;
}

class ComicsState extends Equatable {
  const ComicsState({
    this.status = ComicsStatus.initial,
    required this.comics,
    required this.count,
    required this.total,
    required this.offset,
    required this.legal,
  });

  const ComicsState.initial()
      : status = ComicsStatus.initial,
        comics = const [],
        count = 0,
        total = 0,
        offset = 0,
        legal = '';

  final ComicsStatus status;
  final List<Comic> comics;
  final int count;
  final int total;
  final int offset;
  final String legal;

  @override
  List<Object> get props => [status, comics, count, total, offset, legal];

  ComicsState copyWith({
    ComicsStatus? status,
    List<Comic>? comics,
    int? count,
    int? total,
    int? offset,
    String? legal,
  }) {
    return ComicsState(
      status: status ?? this.status,
      comics: comics ?? this.comics,
      count: count ?? this.count,
      total: total ?? this.total,
      offset: offset ?? this.offset,
      legal: legal ?? this.legal,
    );
  }
}
