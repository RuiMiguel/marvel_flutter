import 'package:marvel/core/controllers/failure.dart';

class Result {
  const Result();

  static Result loading() {
    return Loading();
  }

  static Result error(Failure failure) {
    return Error(failure);
  }

  static Result success(dynamic data) {
    return Success(data);
  }
}

class Loading extends Result {}

class Error<Failure> extends Result {
  final Failure failure;
  const Error(this.failure) : super();
}

class Success<T> extends Result {
  final T data;
  const Success(this.data) : super();
}
