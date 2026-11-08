import 'package:base_flutter/src/core/utils/typedefs.dart';

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();
  ResultFuture<T> call(Params param);
}

abstract class UseCaseWithoutParams<T> {
  const UseCaseWithoutParams();
  ResultFuture<T> call();
}