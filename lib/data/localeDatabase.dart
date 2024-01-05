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
    String path = join(directory.toString(), "mydb.db");
    Database database = await openDatabase(
      path,
      version: 1, // Increase the version number
      onCreate: (db, version) {
        String sql = "CREATE TABLE $tableName(id TEXT,author TEXT,quote TEXT)";
        db.execute(sql);
      },
    );

    return database;
  }

  Future<bool> deleteFavouriteQuote(String id) async {
    try {
      print("called remove $id");
      var dbClient = await db;
      final result = await dbClient!.delete(
        tableName,
        where: "id=?",
        whereArgs: [id],
      );
      print("result is $result");

      if (result == 1) {
        print("value");
        return true;
      } else {
        print("No records deleted.");
        return false;
      }
    } catch (e) {
      print("Error deleting quote: $e");
      return false;
    }
  }

  Future<bool> saveFavouriteQuote(Quote q) async {
    var dbClient = await db;
    if (dbClient != null) {
      try {
        int result = await dbClient.insert(tableName, q.toJson());
        print("Insert result: $result");
        return true;
      } catch (error) {
        print("Error during insert: $error");
        return false;
      }
    }
    return false;
  }

  Future<List<Quote>> getFavouriteQotes() async {
    var dbClient = await db;
    if (dbClient == null) {
      return [];
    }
    List<Map<String, Object?>> result = await dbClient.query(tableName);
    return result.map((e) => Quote.fromJson(e)).toList();
  }
}
