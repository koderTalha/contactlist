import 'dart:developer';

import 'package:contactlist/Model/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database _database;
//generate db on phne using sqflite
  Future<void> opendb() async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, 'contactdb.db');
//never use TABLE name as 'table'
    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      log("database is opeineing");
      return db.execute(
          '''
          CREATE TABLE contacttable(
          id INTEGER PRIMARY KEY,
          name TEXT,
          number TEXT
          )
          ''');
    });
  }

//function to inset contact
  Future<void> insertContact(CONTACT contact) async {
    await _database.insert(
      'contacttable',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//function to delete contact
  Future<void> deleteContact(int id) async {
    await _database.delete(
      'contacttable',
      where: 'id=?',
      whereArgs: [id],
    );
  }

//function to update contact
  Future<void> updateContact(CONTACT contact) async {
    await _database.update('contacttable', contact.toMap(),
        where: 'id=?', whereArgs: [contact.id]);
  }

//function to load contact from local database
  Future<List<CONTACT>> loadContact() async {
    final List<Map<String, dynamic>> list = await _database.query('contacttable');
    return List.generate(list.length, (index) {
      return CONTACT(
        id: list[index]['id'],
        name: list[index]['name'],
        number: list[index]['number'],
      );
    });
  }
}
