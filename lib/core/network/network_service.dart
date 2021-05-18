import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._init();

  static NetworkManager get instance => _instance;
  Dio _dio;

  NetworkManager._init() {
    _dio = Dio();
  }

  Future dioGet({
    @required String baseURL,
    @required String endPoint,
  }) async {
    final response = await _dio.get(
      baseURL + endPoint,
    );
    return response;
  }
}
