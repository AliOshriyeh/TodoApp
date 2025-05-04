// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final int id;
  String title;
  String desc;
  final DateTime crt_date;
  DateTime exp_date;
  String status;
  String priority;

  TaskModel(
    this.exp_date,
    this.priority, {
    required this.id,
    required this.title,
    required this.desc,
    required this.crt_date,
    required this.status,
  }) {
    this.status = "INCOMPLETE";
  }

  // factory TaskModel.fromJson(Map<String, dynamic> jsonResponse) {
  //   var valueOrDefault = jsonResponse['valueOrDefault'];
  //   var value = jsonResponse['value'];
  //   var isFailed = jsonResponse['isFailed'];
  //   var isSuccess = jsonResponse['isSuccess'];
  //   var reasonsList = jsonResponse['reasons'];
  //   var errorList = jsonResponse['errors'];
  //   var successeList = jsonResponse['successes'];

  //   return TaskModel(valueOrDefault: valueOrDefault, value: value, isFailed: isFailed, isSuccess: isSuccess, reasons: reasonsList, errors: errorList, successes: successeList);
  // }

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, desc, crt_date, exp_date, status, priority];
}
