import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/app_error.dart';

AppError mapAuthError(Object error) {

  if (error is AuthApiException) {

    final message = error.message.toLowerCase();

    // Registro
    if (message.contains('user already registered') ||
        message.contains('already registered') ||
        message.contains('email already')) {
      return AppError(
        type: AppErrorType.warning,
        message: 'Este correo electrónico ya está registrado.',
      );
    }

    // Credenciales
    if (message.contains('invalid login credentials')) {
      return AppError(
        type: AppErrorType.warning,
        message: 'Correo o contraseña incorrectos.',
      );
    }

    // Correo inválido
    if (message.contains('invalid email')) {
      return AppError(
        type: AppErrorType.warning,
        message: 'El correo electrónico no es válido.',
      );
    }

    // Contraseña débil
    if (message.contains('password')) {
      return AppError(
        type: AppErrorType.warning,
        message: 'La contraseña no cumple con los requisitos de seguridad.',
      );
    }

    // Confirmación de correo
    if (message.contains('email not confirmed')) {
      return AppError(
        type: AppErrorType.warning,
        message: 'Debes confirmar tu correo electrónico antes de iniciar sesión.',
      );
    }

    // Demasiados intentos
    if (error.statusCode == '429') {
      return AppError(
        type: AppErrorType.warning,
        message: 'Has realizado demasiados intentos. Intenta nuevamente más tarde.',
      );
    }

    // Sin permisos
    if (error.statusCode == '403') {
      return AppError(
        type: AppErrorType.warning,
        message: 'No tienes permisos para realizar esta acción.',
      );
    }

    // Usuario no encontrado
    if (error.statusCode == '404') {
      return AppError(
        type: AppErrorType.warning,
        message: 'No se encontró una cuenta asociada a este correo.',
      );
    }

    return AppError(
      type: AppErrorType.error,
      message: 'Ha ocurrido un error. Intenta nuevamente.',
    );
  }

  return AppError(
    type: AppErrorType.error,
    message: 'Ha ocurrido un error inesperado. Intenta nuevamente más tarde.',
  );
}