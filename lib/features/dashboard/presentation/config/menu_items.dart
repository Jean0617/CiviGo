import '../../../../config/route_config/route_paths.dart';
import '../models/menu_item_model.dart';

// ITEMS DEL MENU INFERIOR DEL DASHBOARD
const menuBottomItems = [
  MenuItemModel(
    iconKey: 'home',
    label: "Inicio",
    route: RoutePaths.dashboardPath,
    allowedRoles: [UserRole.citizen, UserRole.admin]
  ),
  MenuItemModel(
    label: "Incidentes",
    iconKey: 'incidents',
    route: RoutePaths.incidentsPath,
    allowedRoles: [UserRole.citizen, UserRole.admin]
  ),
  MenuItemModel(
    label: "Mapa",
    iconKey: 'map',
    route: RoutePaths.mapIncidentsPath,
    allowedRoles: [UserRole.citizen, UserRole.admin]
  ),
  MenuItemModel(
    iconKey: 'profile',
    label: "Perfil",
    route: RoutePaths.profilePath,
    allowedRoles: [UserRole.citizen, UserRole.admin]
  ),
];

// ITEMS DEL MENU LATERAL DASHBOARD
const menuDashboardItems = [
  MenuItemModel(
    label: "Usuarios",
    iconKey: 'users',
    route: RoutePaths.usersPath,
    allowedRoles: [UserRole.admin]
  ),
  MenuItemModel(
    label: "Entidades",
    iconKey: 'entities',
    route: RoutePaths.entitiesPath,
    allowedRoles: [UserRole.admin]
  ),
  MenuItemModel(
    label: "Incidentes",
    iconKey: 'incidents',
    route: RoutePaths.incidentsPath,
    allowedRoles: [UserRole.citizen, UserRole.admin]
  ),
  MenuItemModel(
    label: "Mapa incidentes",
    iconKey: 'map_incidents',
    route: RoutePaths.mapIncidentsPath,
    allowedRoles: [UserRole.citizen, UserRole.admin]
  ),
  MenuItemModel(
    label: "Modelos IA",
    iconKey: 'models_ia',
    route: RoutePaths.modelsIaPath,
    allowedRoles: [UserRole.admin]
  ),
  MenuItemModel(
    label: "Reportes",
    iconKey: 'reports',
    route: RoutePaths.reportsPath,
    allowedRoles: [UserRole.admin]
  ),
  MenuItemModel(
    label: "Configuración",
    iconKey: 'configuration',
    route: RoutePaths.configurationPath,
    allowedRoles: [UserRole.citizen, UserRole.admin]
  ),
];
