import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:supdup/core/utils/constants.dart';
import 'package:supdup/features/data/datasource/local_datasource.dart';
import 'package:supdup/features/data/model/data_model.dart';

part 'client.g.dart';

/// Remote client for interacting with remote server
@RestApi(baseUrl: "https://picsum.photos/")
abstract class RestClient {
  /// flutter pub run build_runner build --delete-conflicting-outputs
  factory RestClient(final Dio dio, final LocalDataSource localDataSource) {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (option, handler) {
      //Do something before request is sent
      if (localDataSource == null ) {
        // option.headers[Constants.AUTHORIZATION] =
        //     "Bearer " + localDataSource.getAccessToken()!;

        // print(localDataSource.getAccessToken());
        // print(localDataSource.getAccessToken()!);

      }
      return handler.next(option);
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      return handler.next(e); //continue
    }));
    return _RestClient(dio);
  }

  @GET(Constants.API_DATA)
  Future<DataModelResult> getData();
}
