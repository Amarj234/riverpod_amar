import 'package:dio/dio.dart';

import '../core/network/constant/endpoints.dart';

class ApiCall {
  final dio = Dio();
  Future<Response?> getApi() async {
    try {
      final response = await dio.get(Endpoints.product);
      print(response);
      return response;
    } catch (e) {
      print("e");
    }
  }
}
