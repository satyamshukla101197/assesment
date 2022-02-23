import 'package:dartz/dartz.dart';
import 'package:supdup/core/error/failures.dart';
import 'package:supdup/features/domain/entities/data_entity.dart';

abstract class Repository {


  Future<Either<Failure, DataEntity>> getData();
}