// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:task01/data/providers/sqflite_prov.dart';

class TaskModel extends Equatable {
  // --- Task Properties ---
  int id; // Unique identifier for the task
  String title; // Title of the task
  String desc; // Description of the task
  final DateTime crt_date; // Creation date (immutable)
  DateTime exp_date; // Expiration/due date
  String status; // Task status (COMPLETE/INCOMPLETE)
  String priority; // Task priority level

  TaskModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.crt_date,
    required this.exp_date,
    required this.priority,
    required this.status,
  });

  // --- Equatable Implementation ---
  @override
  List<Object?> get props => [id, title, desc, crt_date, exp_date, status, priority];

  // --- Utility Methods ---

  // Creates a copy of the task with updated fields
  TaskModel copyWith({
    int? id,
    String? title,
    String? desc,
    DateTime? crt_date,
    DateTime? exp_date,
    String? priority,
    String? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      crt_date: crt_date ?? this.crt_date,
      exp_date: exp_date ?? this.exp_date,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }

  // --- Database Conversion Methods ---

  // Converts database map to TaskModel object
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    var queryid = map[DatabaseProvider.COLUMN_ID] as int;
    var querytitle = map[DatabaseProvider.COLUMN_TITLE] as String;
    var querydesc = map[DatabaseProvider.COLUMN_DESC] as String;
    var querycrtdate = DateTime.fromMillisecondsSinceEpoch(int.parse(map[DatabaseProvider.COLUMN_CRT_DATE]));
    var queryexpdate = DateTime.fromMillisecondsSinceEpoch(int.parse(map[DatabaseProvider.COLUMN_EXP_DATE]));
    var querystatus = map[DatabaseProvider.COLUMN_STATUS] as String;
    var querypriority = map[DatabaseProvider.COLUMN_PRIORITY] as String;

    return TaskModel(
      id: queryid,
      title: querytitle,
      desc: querydesc,
      crt_date: querycrtdate,
      exp_date: queryexpdate,
      status: querystatus,
      priority: querypriority,
    );
  }

  // Converts TaskModel object to database map
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_ID: id == -1 ? null : id,
      DatabaseProvider.COLUMN_TITLE: title,
      DatabaseProvider.COLUMN_DESC: desc,
      DatabaseProvider.COLUMN_CRT_DATE: crt_date.millisecondsSinceEpoch.toString(),
      DatabaseProvider.COLUMN_EXP_DATE: exp_date.millisecondsSinceEpoch.toString(),
      DatabaseProvider.COLUMN_STATUS: status,
      DatabaseProvider.COLUMN_PRIORITY: priority,
    };
    return map;
  }
}
