
enum AppErrorType {
  success,
  warning,
  error,
  info,
  unknown,
}

class AppError {
  final AppErrorType type;
  final String message;
  final int? code;

  const AppError({
    required this.type,
    required this.message,
    this.code,
  });
}
