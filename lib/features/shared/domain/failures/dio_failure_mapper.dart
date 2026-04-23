import 'package:dio/dio.dart';
import 'app_failure.dart';

AppFailure mapDioError(DioException e) {
  final statusCode = e.response?.statusCode;

  /// HTTP STATUS CODES
  if (statusCode != null) {
    switch (statusCode) {
      case 400:
        return const BadRequestFailure();

      case 401:
        return const Unauthorized();

      case 403:
        return const Forbidden();

      case 404:
        return const NotFound();

      case 409:
        return const ConflictFailure();

      case 422:
        return const ValidationFailure();

      case 429:
        return const TooManyRequestsFailure();

      case 500:
        return const InternalServerFailure();

      case 502:
        return const BadGatewayFailure();

      case 503:
        return const ServiceUnavailableFailure();

      case 504:
        return const GatewayTimeoutFailure();

      default:
        if (statusCode >= 500) {
          return const InternalServerFailure();
        }
    }
  }

  /// DIO EXCEPTION TYPES
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return const ConnectionTimeoutFailure();

    case DioExceptionType.sendTimeout:
      return const SendTimeoutFailure();

    case DioExceptionType.receiveTimeout:
      return const ReceiveTimeoutFailure();

    case DioExceptionType.connectionError:
      return const NetworkError();

    case DioExceptionType.cancel:
      return const RequestCancelledFailure();

    case DioExceptionType.badCertificate:
      return const BadCertificateFailure();

    case DioExceptionType.badResponse:
      return const BadResponseFailure();

    case DioExceptionType.unknown:
      return const UnknownError();
  }
}
