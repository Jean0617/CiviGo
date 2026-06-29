import 'package:intl/intl.dart';

class DateUtilsApp {

  static String formatDateTime(String date) {
    final dateTime = DateTime.parse(date).toLocal();

    return DateFormat(
      'd MMM yyyy hh:mm a', 'es_CO',
    ).format(dateTime)
      .replaceAll('AM', 'a. m.')
      .replaceAll('PM', 'p. m.');
  }

  static String formatHour(String date) {
    final dateTime = DateTime.parse(date).toLocal();

    return DateFormat(
      'hh:mm a', 'es_CO',
    ).format(dateTime)
      .replaceAll('AM', 'a. m.')
      .replaceAll('PM', 'p. m.');
  }

 static String timeAgo(String date) {
    final dateTime = DateTime.parse(date).toLocal();
    final now = DateTime.now();

    final difference = now.difference(dateTime);

    // Menos de 1 minuto
    if (difference.inSeconds < 60) {
      return 'Ahora';
    }

    // Menos de 1 hora
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min';
    }

    // Menos de 24 horas
    if (difference.inHours < 24) {
      final hours = difference.inHours;
      final minutes = difference.inMinutes % 60;

      if (minutes == 0) {
        return hours == 1 ? '1 hora' : '$hours horas';
      }

      return '${hours == 1 ? '1 hora' : '$hours horas'} y $minutes min';
    }

    // 1 día o más
    final days = difference.inDays;

    if (days == 1) {
      return '1 día';
    }

    return '$days días';
  }
}