import 'app_error.dart';

class AppErrorEntity {
  final AppErrorType type;
  final String message;
  final int? code;

  const AppErrorEntity({
    required this.type,
    required this.message,
    this.code,
  });
}
