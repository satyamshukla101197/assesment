import 'package:dartz/dartz.dart';
import 'package:supdup/core/error/exceptions.dart';
import 'package:supdup/core/error/failures.dart';
import 'package:supdup/core/network/network_info.dart';
import 'package:supdup/core/utils/constants.dart';
import 'package:supdup/features/data/datasource/local_datasource.dart';
import 'package:supdup/features/data/datasource/remote_datasource.dart';
import 'package:supdup/features/domain/entities/data_entity.dart';
import 'package:supdup/features/domain/repositories/repository.dart';

class RepositoryImpl extends Repository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});
  @override
  Future<Either<Failure, DataEntityResult>> getData() async {
    if (await networkInfo.isConnected) {
      try {
        final dataDetails = await remoteDataSource.getData();
        final dataResult = List<DataEntityResult>.empty(growable: true);

        // dataDetails.Result!.forEach((element) {
        //   dataResult.add(DataEntityResult(
        //       id: element.id,
        //     author: element.author,
        //     width: element.width,
        //     height: element.height,
        //     url: element.url,
        //     download_url: element.download_url
        //   ));
        // });


        return Right(DataEntityResult(
            id: dataDetails.id,
            author: dataDetails.author,
            width: dataDetails.width,
            height: dataDetails.height,
            url: dataDetails.url,
            download_url: dataDetails.download_url

        ));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: Constants.ERROR_NO_INTERNET));
    }
  }

}
