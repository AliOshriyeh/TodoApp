// ignore_for_file: constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task01/configs/consts.dart';
import 'package:task01/data/models/task_model.dart';

class DatabaseProvider {
  static const String TABLE_TASK = "TaskModel";
  static const String COLUMN_ID = "id";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_DESC = "desc";
  static const String COLUMN_CRT_DATE = "crt_date";
  static const String COLUMN_EXP_DATE = "exp_date";
  static const String COLUMN_STATUS = "status";
  static const String COLUMN_PRIORITY = "priority";

  DatabaseProvider._privateConstructor();
  static final DatabaseProvider instance = DatabaseProvider._privateConstructor();

  Future<Database> _initDatabase() async {
    final dirPath = await getDatabasesPath();
    final dbDir = Directory(dirPath);

    if (!await dbDir.exists()) {
      await dbDir.create(recursive: true);
    }
    final dbPath = join(dirPath, 'tasks.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<Database> get database async {
    var newDatabase = await _initDatabase();
    return newDatabase;
  }

  Future _onCreate(Database db, int version) async {
    debugPrint(printSignifier + "Creating TaskModel Table");
    await db.execute('''
      CREATE TABLE $TABLE_TASK(
        $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $COLUMN_TITLE TEXT NOT NULL,
        $COLUMN_DESC TEXT NOT NULL,
        $COLUMN_CRT_DATE TEXT NOT NULL,
        $COLUMN_EXP_DATE TEXT NOT NULL,
        $COLUMN_STATUS TEXT NOT NULL,
        $COLUMN_PRIORITY TEXT NOT NULL
      )
    ''');
  }
  // CRUD Operations

  // Add
  Future<int> insertTask(TaskModel task) async {
    debugPrint(printSignifier + "Inserting Tasks in Database...");
    Database db = await instance.database;
    var id = await db.insert(TABLE_TASK, task.toMap());
    debugPrint(printSignifier + "Item #$id was Inserted in Database");
    return id;
  }

  // Read all
  Future<List<TaskModel>> getTasks() async {
    debugPrint(printSignifier + "Fetching Tasks from Database...");
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_TASK);

    List<TaskModel> taskList = List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
    return taskList;
  }

  // Read single
  Future<TaskModel?> getTask(int id) async {
    Database db = await instance.database;
    final maps = await db.query(
      TABLE_TASK,
      where: '$COLUMN_ID = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return TaskModel.fromMap(maps.first);
    }
    return null;
  }

  // Update
  Future<int> updateTask(TaskModel task) async {
    debugPrint(printSignifier + "Updating Tasks in Database...");
    Database db = await instance.database;
    var id = await db.update(TABLE_TASK, task.toMap(), where: '$COLUMN_ID = ?', whereArgs: [task.id]);
    debugPrint(printSignifier + "Item #$id was Modified in Database");
    return id;
  }

  // Delete
  Future<int> deleteTask(int id) async {
    debugPrint(printSignifier + "Deleting Tasks from Database...");
    Database db = await instance.database;
    debugPrint(printSignifier + "Item #$id was Deleted from Database");
    return await db.delete(TABLE_TASK, where: 'id = ?', whereArgs: [id]);
  }

  void close() async {
    debugPrint(printSignifier + "Closing TaskModel Database...");
    Database db = await instance.database;
    db.close();
  }
}
