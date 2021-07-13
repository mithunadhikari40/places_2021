import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:places/src/core/constants/app_constants.dart';
import 'package:places/src/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  Database? _db;

  static Map<int, List<String>> migrations = {
    2:["ALTER TABLE $USER_TABLE ADD COLUMN profilePic TEXT"],
    3:["ALTER TABLE $USER_TABLE ADD COLUMN coverPic TEXT"],
  };

  DbProvider() {
    _init();
  }

  Future<void> _init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    final dbPath = path.join(dir.path, DB_NAME);
    _db = await openDatabase(
      dbPath,
      version: 3,
      onCreate: (Database newDb, int version) {
        Batch batch = newDb.batch();
        batch.execute("""
            CREATE TABLE $USER_TABLE (
              id TEXT PRIMARY KEY,
              isAdmin INTEGER,
              name TEXT,
              email TEXT,
              phone INTEGER,
              registrationDate TEXT
            )
        """);
       for(var item in migrations.values){
         item.forEach((element) {
           batch.execute(element);
         });
       }
        batch.commit();
      },
      onUpgrade: (Database newDb, int oldVersion, int newVersion){
        Batch batch = newDb.batch();
        /// newVersion -3, oldVersion -> 1/2

        for(int i =oldVersion+1;i <= newVersion;i++){
          migrations[i]!.forEach((element) {
            batch.execute(element);
          });

        }
        batch.commit();

      }
    );
  }




  Future<int> insertUser(UserModel user) async {
    if (_db == null) await _init();
    await _db!.delete(USER_TABLE);
    return _db!.insert(USER_TABLE, user.toDb());
  }

  Future<int> updateName(String id, UserModel user) async {
    if (_db == null) await _init();
    return _db!
        .update(USER_TABLE, user.toDb(), where: "id = ?", whereArgs: [id]);
  }

  Future<UserModel?> getUser() async {
    if (_db == null) await _init();
    final data = await _db!.query(USER_TABLE);
    if (data.length != 1) return null;
    return UserModel.fromDb(data.first);
  }

  Future<void> clear() async {
    if (_db == null) await _init();
    _db!.delete(USER_TABLE);
  }
}
