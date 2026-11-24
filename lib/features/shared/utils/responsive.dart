import 'package:flutter/material.dart';

/// Puntos de corte de la app. Por debajo de [tablet] se usa el diseño móvil sin cambios.
class Breakpoints {
  Breakpoints._();

  static const double tablet = 700;
  static const double desktop = 1000;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  bool get isTabletUp => screenWidth >= Breakpoints.tablet;
  bool get isDesktop => screenWidth >= Breakpoints.desktop;
}

/// Centra [child] y limita su ancho. En pantallas angostas no tiene efecto.
class ContentConstraint extends StatelessWidget {
  final double maxWidth;
  final Widget child;

  const ContentConstraint({super.key, this.maxWidth = 1100, required this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

/// Para pantallas de flujo (asistente, vista previa, etc.): en pantallas anchas se muestran
/// como una tarjeta centrada sobre un fondo suave. En móvil devuelve [child] tal cual.
class NarrowPage extends StatelessWidget {
  final double maxWidth;
  final Widget child;

  const NarrowPage({super.key, this.maxWidth = 560, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!context.isTabletUp) return child;

    return ColoredBox(
      color: const Color(0xFFEFF3F2),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          margin: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 24, offset: Offset(0, 8)),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
      ),
    );
  }
}
