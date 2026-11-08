import 'package:dartz/dartz.dart';
import '../api/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef DataMap = Map<String, dynamic>;

typedef SubmitVoidFunc = void Function(String?, String?, String);