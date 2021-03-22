import 'dart:io';
import 'package:flutter_mobile_template/data_models/dog.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), "people_database.db");
    return openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Dog ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "age INTEGER"
          ")");
    });
  }

  insertDog(Dog dog) async {
    final db = await database;
    return await db?.insert('dog', dog.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    /*
    *    return await db.rawInsert(
    *    "INSERT INTO Dog(id,name,age)"
    *    " VALUES (?,?,?)",
    *    [dog.id, dog.name, dog.age]);
    */
  }

  Future<List<Dog>> getAllDogs() async {
    final db = await database;
    final List<Map<String, Object?>>? res =
        await db?.query("Dog").whenComplete(() {
      print("Completeed featching!");
    });

    List<Dog> list =
        res!.isNotEmpty ? res.map((c) => Dog.fromJson(c)).toList() : [];
    return list;
  }

  updateDog(Dog newClient) async {
    final db = await database;
    var res = await db?.update("Dog", newClient.toJson(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  deleteDog(String id) async {
    final db = await database;
    return db?.delete("Dog", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    return db?.rawDelete("Delete * from People");
  }
}
