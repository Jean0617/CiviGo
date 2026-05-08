import 'package:flutter_riverpod/legacy.dart';

// Modelo simple para el rango
class DateRange {
  final DateTime desde;
  final DateTime hasta;
  DateRange({required this.desde, required this.hasta});

  DateRange copyWith({DateTime? desde, DateTime? hasta}) {
    return DateRange(
      desde: desde ?? this.desde,
      hasta: hasta ?? this.hasta,
    );
  }
}

final reportDateProvider = StateProvider<DateRange>((ref) {
  return DateRange(
    desde: DateTime(2023, 9, 1),
    hasta: DateTime(2023, 9, 30),
  );
});