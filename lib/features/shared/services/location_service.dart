import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentLocation() async {

  try {

    // Validar si el GPS del dispositivo está activo
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception(
        'Los servicios de ubicación están desactivados.',
      );
    }

    // Validar permisos actuales
    LocationPermission permission = await Geolocator.checkPermission();

    // Solicitar permisos si no existen
    if (permission == LocationPermission.denied) {

      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw Exception(
          'Permiso de ubicación denegado.',
        );
      }
    }

    /// Permisos bloqueados permanentemente
    if (permission == LocationPermission.deniedForever) {

      throw Exception(
        'El permiso de ubicación fue bloqueado permanentemente.',
      );
    }

    /// Obtener ubicación actual
    final Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      ),
    );

    return position;

  } catch (e) {

    print(
      'Error obteniendo ubicación: $e',
    );

    return null;
  }
}