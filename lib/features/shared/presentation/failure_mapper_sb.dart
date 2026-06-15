import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/app_error.dart';

AppError mapAuthError(Object error) {

  if (error is AuthApiException) {

    switch (error.statusCode) {

      case '400':
        return AppError(
          type: AppErrorType.warning,
          message: 'Credenciales inválidas.',
        );

      case '401':
        return AppError(
          type: AppErrorType.warning,
          message: 'Correo o contraseña incorrectos.',
        );

      case '403':
        return AppError(
          type: AppErrorType.warning,
          message: 'No tienes permisos para realizar esta acción.',
        );

      case '404':
        return AppError(
          type: AppErrorType.warning,
          message: 'Usuario no encontrado.',
        );

      case '422':
        return AppError(
          type: AppErrorType.warning,
          message: 'Los datos enviados no son válidos.',
        );

      case '429':
        return AppError(
          type: AppErrorType.warning,
          message: 'Demasiados intentos. Intenta nuevamente más tarde.',
        );

      case '500':
        return AppError(
          type: AppErrorType.error,
          message: 'Error interno del servidor.',
        );

      default:
        return AppError(
          type: AppErrorType.error,
          message: error.message,
        );
    }
  }

  return AppError(
    type: AppErrorType.error,
    message: 'Ha ocurrido un error inesperado. Intenta nuevamente más tarde.',
  );
}