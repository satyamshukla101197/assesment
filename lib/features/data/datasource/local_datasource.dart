
import 'package:supdup/core/config/db_provider.dart';
import 'package:supdup/core/config/my_shared_pref.dart';

/// Abstract class for saving/loading data from local storage
abstract class LocalDataSource {}

/// Implementation class used for saving/loading data from Local storage
class LocalDataSourceImpl extends LocalDataSource {
  final MySharedPref mySharedPref;
  final DBProvider dbProvider;

  LocalDataSourceImpl({
    required this.mySharedPref,
    required this.dbProvider,
  });
}
