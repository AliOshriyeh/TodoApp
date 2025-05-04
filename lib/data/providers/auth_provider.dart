// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:task01/data/models/task_model.dart';

// class VerifyDataProvider {
//   final Dio _dio = Dio();
//   final String _getCodeUrl = "https://sit-credit.saminray.com/auth/Auth/SendCode";
//   final String _loginUrl = "https://sit-credit.saminray.com/auth/Auth/Login";

//   // ⁡⁢⁣⁢Verification 𝗦𝘁𝗲𝗽 𝟭 - Get Code⁡
//   Future<VerifyModel> sendCode(String phoneNo) async {
//     try {
//       final response = await _dio.post(
//         _getCodeUrl,
//         options: Options(
//           headers: <String, String>{
//             'accept': 'text/plain',
//             'BusinessKey': '1da5ce01-7491-44a2-a823-2f4734ef0aef',
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//         ),
//         data: jsonEncode(<String, String>{
//           'phoneNo': phoneNo,
//         }),
//       );

//       if (response.statusCode == 200) {
//         return VerifyModel.fromJson(response.data);
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } on DioException catch (e) {
//       throw Exception('Failed to load data: ${e.message}');
//     }
//   }

//   // ⁡⁢⁣⁢Verification 𝗦𝘁𝗲𝗽 𝟮 - Login⁡
//   Future<VerifyModel> login(int loginCode) async {
//     try {
//       final response = await _dio.post(
//         _loginUrl,
//         options: Options(
//           headers: <String, String>{
//             'accept': 'text/plain',
//             'BusinessKey': '1da5ce01-7491-44a2-a823-2f4734ef0aef',
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//         ),
//         data: jsonEncode(<String, dynamic>{
//           'phoneNo': "string",
//           'loginCode': loginCode,
//         }),
//       );

//       if (response.statusCode == 200) {
//         return VerifyModel.fromJson(response.data);
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } on DioException catch (e) {
//       throw Exception('Failed to load data: ${e.message}');
//     }
//   }
// }
