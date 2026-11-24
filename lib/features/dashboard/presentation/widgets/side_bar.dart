import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_config/app_config.dart';
import '../../../../config/route_config/route_paths.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../config/menu_items.dart';
import '../models/menu_item_model.dart';
import '../utils/icon_mapper.dart';

/// Barra lateral para pantallas de escritorio. Reutiliza los mismos ítems y roles del menú móvil.
class SideBar extends ConsumerWidget {
  final String location;

  const SideBar({super.key, required this.location});

  static const double width = 260;

  bool _isSelected(MenuItemModel item) {
    if (location.startsWith(item.route)) return true;
    // El detalle de incidencia pertenece a la sección Incidentes
    return item.route == RoutePaths.incidentsPath && location.startsWith('/incident_detail');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final user = ref.watch(authProvider).user;
    final data = user?.identities?[0].identityData;
    final role = (data?['role'] ?? '') as String;

    final adminItems = menuDashboardItems.where((item) =>
      // "Configuración" aún no tiene pantalla registrada en el router
      item.route != RoutePaths.configurationPath &&
      item.allowedRoles.any((r) => r.name == role),
    ).toList();

    return Container(
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppConfig.primaryColor, Color(0xFF02473D)],
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Marca
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Row(
                children: [
                  const Icon(Icons.security_outlined, color: Colors.white, size: 32),
                  const SizedBox(width: 10),
                  const UIText(title: AppConfig.appName, size: 24, bold: true, color: Colors.white),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: UIText(title: AppConfig.appLema, size: 11, color: Colors.white70),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  for (final item in menuBottomItems) _tile(context, item),

                  if (adminItems.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(12, 20, 12, 6),
                      child: UIText(title: 'ADMINISTRACIÓN', size: 11, bold: true, color: Colors.white54),
                    ),
                    for (final item in adminItems) _tile(context, item),
                  ],
                ],
              ),
            ),

            // Usuario + cerrar sesión
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(25),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white70,
                    backgroundImage: AssetImage('assets/avatar/profile_boy.png'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: UIText(
                      title: data?['name'] ?? 'Usuario',
                      size: 13, bold: true, color: Colors.white,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Cerrar sesión',
                    onPressed: () => ref.read(authProvider.notifier).logOut(),
                    icon: const Icon(Icons.logout, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(BuildContext context, MenuItemModel item) {
    final selected = _isSelected(item);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => context.go(item.route),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Icon(
                  iconMap[item.iconKey] ?? Icons.help_outline,
                  size: 20,
                  color: selected ? AppConfig.primaryColor : Colors.white,
                ),
                const SizedBox(width: 12),
                UIText(
                  title: item.label,
                  size: 14,
                  bold: selected,
                  color: selected ? AppConfig.primaryColor : Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
