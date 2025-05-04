// // ignore_for_file: avoid_function_literals_in_foreach_calls

// import 'package:get/get.dart';
// import 'package:task01/data/models/task_model.dart';
// import 'package:task01/data/providers/auth_provider.dart';

// class VerifyRepository {
//   final VerifyDataProvider dataProvider = VerifyDataProvider();

//   Future<bool> sendCode(String phoneNo) async {
//     VerifyModel rawResponse = await dataProvider.sendCode(phoneNo);
//     bool wasSuccess = rawResponse.isSuccess;
//     rawResponse.reasons.forEach((message) => Get.snackbar(wasSuccess ? "SUCCESS" : "Error", message['message']));

//     return wasSuccess;
//   }

//   Future<bool> login(String loginCode) async {
//     VerifyModel rawResponse = await dataProvider.login(int.parse(loginCode));
//     bool wasSuccess = rawResponse.isSuccess;
//     rawResponse.reasons.forEach((message) => Get.snackbar(wasSuccess ? "SUCCESS" : "Error", message['message']));

//     return wasSuccess;
//   }
// }
