import 'package:flutter/material.dart';

import '../../../../config/app_config/app_config.dart';
import '../text/ui_text.dart';

/// Marco de las pantallas de acceso (login / registro).
/// En pantallas anchas: panel de marca a la izquierda y formulario centrado a la derecha.
/// En móvil devuelve [child] sin cambios.
class AuthLayout extends StatelessWidget {
  final Widget child;
  final double formMaxWidth;

  const AuthLayout({super.key, required this.child, this.formMaxWidth = 460});

  static const double _splitBreakpoint = 900;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < _splitBreakpoint) return child;

        return Row(
          children: [
            const Expanded(flex: 5, child: BrandPanel()),
            Expanded(
              flex: 4,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: formMaxWidth),
                  child: child,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Panel verde con la identidad de CiviGo.
class BrandPanel extends StatelessWidget {
  const BrandPanel({super.key});

  @override
  Widget build(BuildContext context) {
    const points = [
      (Icons.camera_alt_outlined, 'Reporta con una foto', 'Captura la evidencia y tu ubicación en segundos.'),
      (Icons.auto_awesome_outlined, 'La IA clasifica por ti', 'Detecta la categoría, el riesgo y la entidad responsable.'),
      (Icons.track_changes_outlined, 'Sigue tu reporte', 'Consulta el estado hasta que sea resuelto.'),
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppConfig.primaryColor, Color(0xFF02473D)],
        ),
      ),
      padding: const EdgeInsets.all(56),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.security_outlined, color: Colors.white, size: 56),
              const SizedBox(height: 16),
              const UIText(title: AppConfig.appName, size: 44, bold: true, color: Colors.white),
              const SizedBox(height: 6),
              UIText(title: AppConfig.appLema, size: 18, color: AppConfig.secundaryColor),
              const SizedBox(height: 48),
              for (final p in points)
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(p.$1, color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UIText(title: p.$2, size: 16, bold: true, color: Colors.white),
                            const SizedBox(height: 2),
                            UIText(title: p.$3, size: 13, color: Colors.white70),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
