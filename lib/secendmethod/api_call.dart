import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:riverpod_api/core/network/constant/endpoints.dart';

class ApiCall {
  final dio = Dio();
  Future<Response?> getApi() async {
    try {
      final response = await dio.get(Endpoints.product);
      if (kDebugMode) {
        print(response);
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('e');
      }
    }
    return null;
  }
}
