import 'dart:core';
import 'package:dartz/dartz.dart';

class TestException implements Exception {
  const TestException();

  @override
  String toString() => 'TestException';
}

extension EitherTestHelper<L, R> on Either<L, R> {
  L l() => fold((l) => l, (r) => throw const TestException());
  R r() => fold((l) => throw const TestException(), (r) => r);
}
