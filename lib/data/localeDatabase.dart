import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

import '../model/quoteModel.dart';

class DBController {
  static Database? database;
  static String tableName = "favourite_quote";
  Future<Database?> get db async {
    if (database != null) {
      return database;
    }
    database = await initDatabase();
    return database;
  }

  Future<Database> initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.toString(), "db.db");
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String sql =
            "CREATE TABLE $tableName(id INTEGER PRIMARY KEY,author TEXT,quote TEXT)";
        db.execute(sql);
      },
    );
    return database;
  }

  Future<bool> deleteFavouriteQuote(int id) async {
    var dbClient = await db;
    await dbClient!.delete(
      tableName,
      where: "id=?",
      whereArgs: ['id'],
    ).then((value) {
      return true;
    });
    return false;
  }

  Future<int> saveFavouriteQuote(Quote q) async {
    var dbClient = await db;
    if (dbClient != null) {
      dbClient.insert(tableName, q.toJson()).then((value) {
        return value;
      });
    }
    return 0;
  }

  Future<List<Quote>> getFavouriteQotes() async {
    var dbClient = await db;
    if (dbClient != null) {
      return [];
    }
    List<Map<String, Object?>> result = await dbClient!.query(tableName);
    return result.map((e) => Quote.fromJson(e)).toList();
  }
}
