import 'package:core_domain/core_domain.dart';

class Result {
  const Result();

  static Result loading() {
    return Loading();
  }

  static Result error(Failure failure) {
    return Error(failure);
  }

  static Result success<T>(T data) {
    return Success(data);
  }

  bool isLoading() {
    return this is Loading;
  }

  bool isError() {
    return this is Error;
  }

  bool isSuccess() {
    return this is Success;
  }
}

class Loading extends Result {}

class Error<Failure> extends Result {
  const Error(this.failure) : super();
  final Failure failure;
}

class Success<T> extends Result {
  const Success(this.data) : super();
  final T data;
}
