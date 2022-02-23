import 'package:dartz/dartz.dart';
import 'package:supdup/core/error/failures.dart';
import 'package:supdup/core/usecse/usecase.dart';
import 'package:supdup/features/domain/entities/data_entity.dart';
import 'package:supdup/features/domain/repositories/repository.dart';

class DataUseCase extends UseCase<DataEntity, NoParams> {
  final Repository _repository;

  DataUseCase(this._repository);

  @override
  Future<Either<Failure, DataEntity>> call(NoParams params) async {
    return await _repository.getData();
  }
}