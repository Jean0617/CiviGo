
import '../domain/app_error.dart';
import '../domain/failures/app_failure.dart';

class FailureMapper {
  const FailureMapper._();

  static AppError map(AppFailure failure) {
    return switch (failure) {

      /// HTTP ERRORS
      BadRequestFailure _ => const AppError(
        type: AppErrorType.warning,
        message: 'Solicitud inválida. Verifica los datos enviados.',
        code: 400,
      ),

      Unauthorized _ => const AppError(
        type: AppErrorType.warning,
        message: 'Tu sesión ha expirado. Inicia sesión nuevamente.',
        code: 401,
      ),

      Forbidden _ => const AppError(
        type: AppErrorType.error,
        message: 'No tienes permisos para realizar esta acción.',
        code: 403,
      ),

      NotFound _ => const AppError(
        type: AppErrorType.warning,
        message: 'El recurso solicitado no fue encontrado.',
        code: 404,
      ),

      ConflictFailure _ => const AppError(
        type: AppErrorType.warning,
        message: 'Ya existe un registro con esta información.',
        code: 409,
      ),

      ValidationFailure _ => const AppError(
        type: AppErrorType.warning,
        message: 'Algunos datos ingresados no son válidos.',
        code: 422,
      ),

      TooManyRequestsFailure _ => const AppError(
        type: AppErrorType.warning,
        message: 'Has realizado demasiadas solicitudes. Intenta más tarde.',
        code: 429,
      ),

      InternalServerFailure _ => const AppError(
        type: AppErrorType.error,
        message: 'Ocurrió un error interno en el servidor.',
        code: 500,
      ),

      BadGatewayFailure _ => const AppError(
        type: AppErrorType.error,
        message: 'El servidor no respondió correctamente.',
        code: 502,
      ),

      ServiceUnavailableFailure _ => const AppError(
        type: AppErrorType.error,
        message: 'El servicio no está disponible temporalmente.',
        code: 503,
      ),

      GatewayTimeoutFailure _ => const AppError(
        type: AppErrorType.error,
        message: 'El servidor tardó demasiado en responder.',
        code: 504,
      ),

      /// NETWORK ERRORS
      NetworkError _ => const AppError(
        type: AppErrorType.warning,
        message: 'Sin conexión a internet.',
      ),

      ConnectionTimeoutFailure _ => const AppError(
        type: AppErrorType.warning,
        message: 'Tiempo de conexión agotado.',
      ),

      SendTimeoutFailure _ => const AppError(
        type: AppErrorType.warning,
        message: 'Tiempo agotado al enviar la solicitud.',
      ),

      ReceiveTimeoutFailure _ => const AppError(
        type: AppErrorType.warning,
        message: 'Tiempo agotado al recibir respuesta del servidor.',
      ),

      RequestCancelledFailure _ => const AppError(
        type: AppErrorType.warning,
        message: 'La solicitud fue cancelada.',
      ),

      BadCertificateFailure _ => const AppError(
        type: AppErrorType.error,
        message: 'Problema de seguridad con el certificado del servidor.',
      ),

      BadResponseFailure _ => const AppError(
        type: AppErrorType.error,
        message: 'Respuesta inválida del servidor.',
      ),

      /// UNKNOWN
      UnknownError _ => const AppError(
        type: AppErrorType.error,
        message: 'Ocurrió un error inesperado.',
      ),
    };
  }
}