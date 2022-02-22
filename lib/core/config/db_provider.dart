import 'package:sqflite/sqflite.dart';
import 'package:supdup/core/utils/constants.dart';
import 'package:supdup/features/data/model/sign_up_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider instance = DBProvider();
//Create a private constructor

  Future<Database?> getInstance() async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  /// Initializing the database
  _initDB() async {
    return await openDatabase(Constants.DB_NAME, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE ${DBConstants.TABLE_USER} "
              "("
              "${DBConstants.NAME} TEXT, "
              "${DBConstants.EMAIL} TEXT, "
              "${DBConstants.PASSWORD} TEXT, "
              "${DBConstants.NUMBER} TEXT, "
              "${DBConstants.IMAGE} TEXT "
              ")");
    });

  }


  // Insert LoginData in Database
  insertData(DetailsSuccessResult successResultModel) async {
    // await deleteAllEmployees();
    final db = await getInstance();
    final result=await db!.insert('${DBConstants.TABLE_USER}', successResultModel.toJson());
    print('INSERT Expense $result');
    return result;
  }



//get login data
  Future<DetailsSuccessResult?> getLogin(String user, String password) async {
    var dbClient = await getInstance();
    var res = await dbClient!.rawQuery("SELECT * FROM ${DBConstants.TABLE_USER} WHERE ${DBConstants.EMAIL} = '$user' and ${DBConstants.PASSWORD} = '$password'");

    if (res.length > 0) {
      return new DetailsSuccessResult.fromJson(res.first);
    }
    return null;
  }



  Future<List?> getAllUser() async {
    var dbClient = await getInstance();
    var res = await dbClient!.query('${DBConstants.TABLE_USER}');

    List? list = res.isNotEmpty ? res.map((c) => DetailsSuccessResult.fromJson(c)).toList() : null;
print(list);
    return list;
  }
}
