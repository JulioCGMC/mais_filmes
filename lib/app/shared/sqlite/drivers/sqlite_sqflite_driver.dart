import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/constants/metadata.dart';
import '../../../core/database/tables.dart' as migrations;
import '../interfaces/sqlite_driver.dart';

class SqliteSqfliteDriver extends Disposable implements ISqliteDriver {
  final Completer<Database> _instance = Completer<Database>();
  late final String boxName;
  
  SqliteSqfliteDriver() {
    boxName = "db_${Metadata.appName.replaceAll(' ', '_').toLowerCase()}";
    _init();
  }

  _init() async {
    Database db = await openDatabase(boxName,
      version: 1,
      onCreate: _onCreate
    );
    _instance.complete(db);
  }

  @override
  Future<bool> delete(String table, {String? where}) async {
    var db = await _instance.future;
    return (await db.delete(table, where: where) > 0);
  }

  @override
  Future<Map<String, Object?>> get(String table, {bool? distinct, 
    List<String>? columns, String? where, List<Object?>? whereArgs, 
    String? groupBy, String? having, String? orderBy}) async {
    var db = await _instance.future;
    return (await db.query(table, 
      distinct: distinct, 
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: 1,
    )).first;
  }

  @override
  Future<int> insert(String table, Map<String, Object?> values) async {
    var db = await _instance.future;
    return db.insert(table, values, 
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Map<String, Object?>>> select(String table, {bool? distinct, 
    List<String>? columns, String? where, List<Object?>? whereArgs, 
    String? groupBy, String? having, String? orderBy,
    int? limit, int? offset}) async {
    var db = await _instance.future;
    return db.query(table, 
      distinct: distinct, 
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset
    );
  }

  @override
  Future<int> update(String table, Map<String, Object?> values, 
    {String? where}) async {
    var db = await _instance.future;
    return db.update(table, values, where: where);
  }

  /// Add table to database
  static _onCreate(db, versao) async {
    for (var table in migrations.tables) {
      var _sql = "CREATE TABLE ${table.name} (${table.fields.join(', ')});";
      await db.execute(_sql);
    }
  }

  @override
  void dispose() async {
    (await _instance.future).close();
  }
}