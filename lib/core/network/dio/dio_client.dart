import 'package:dio/dio.dart';
import '../../../config/api_config/api_config.dart';

class DioClient {
  late final Dio dio;
  final url = Api.baseUrl;

  DioClient() {

    dio = Dio(
      BaseOptions(
        baseUrl: url,
      ),
    );

    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (options, handler) async {
          
    //       final token = await storage.getToken();
          
    //       if (token != null) {
    //         options.headers['Authorization'] = 'Bearer $token';
    //       }

    //       handler.next(options);
    //     },
    //   ),
    // );
  }
}
