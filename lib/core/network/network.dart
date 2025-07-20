import 'package:dio/dio.dart';
import 'package:weather/core/error/exceptions.dart';
import 'package:weather/core/network/endpoints.dart';

abstract class NetworkInterface {
  Future<Response> get(String endPoint, dynamic body);
  Future<Response> post(String endPoint, dynamic body);
  Future<Response> put(String endPoint, dynamic body);
  Future<Response> delete(String endPoint, dynamic body);
}

class Network implements NetworkInterface {
  final Dio dio;
  Network({required this.dio});

  late Map<String, String?> headers;

  Future<Response> _req(Future<Response> Function() requestType) async {
    headers = {'Content-Type': 'application/json'};
    try {
      final response = await requestType();
      if (response.statusCode! > 210 || response.statusCode! < 200) {
        // Logger().i(response.data);
        throw response.data;
      }
      // success
      return response;
    } on DioException catch (e) {
      // Logger().i(e.message);
      throw ServerException(message: e.message);
    } catch (e) {
      // Logger().i(e);
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Response> post(String endPoint, dynamic body) async {
    return _req(() {
      return dio.post(
        Endpoints.baseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
    });
  }

  @override
  Future<Response> put(String endPoint, dynamic body) {
    return _req(() {
      return dio.put(
        Endpoints.baseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
    });
  }

  @override
  Future<Response> delete(String endPoint, dynamic body) {
    return _req(() {
      return dio.delete(
        Endpoints.baseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
    });
  }

  @override
  Future<Response> get(String endPoint, dynamic body) {
    return _req(() {
      return dio.get(
        Endpoints.baseUrl + endPoint,
        options: Options(headers: headers),
      );
    });
  }
}
