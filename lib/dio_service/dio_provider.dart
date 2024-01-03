import 'package:dio/dio.dart';
import 'package:map_flutter/constants/end_points.dart';

class DioProvider {
  static final DioProvider _instance = DioProvider._internal();

  static DioProvider get instance => _instance;
  bool _initialized = false;
  late Dio dio;

  DioProvider._internal();

  Dio get() {
    if (!_initialized) _init();
    return dio;
  }

  void _init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseApiUrl,
        receiveDataWhenStatusError: true,
        connectTimeout:  const Duration(seconds: 20),
      ),
    );
    _initialized = true;
  }
}
