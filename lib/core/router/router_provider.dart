

import 'package:civigo/features/auth/presentation/providers/auth_provider.dart';
import 'package:civigo/features/reports/presentation/pages/preview_photo.dart';

import 'package:civigo/features/entities/presentation/pages/entities.dart';
import 'package:civigo/features/reports2/presentation/pages/reports.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config/route_config/route_paths.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_body_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/dashboard/presentation/pages/menu_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/map/presentation/pages/map_page.dart';
import '../../features/reports/presentation/pages/analyze_ai_page.dart';
import '../../features/reports/presentation/pages/incident_detail.dart';
import '../../features/reports/presentation/pages/screens.dart';
import '../../features/users/presentation/pages/new_user_page.dart' hide Step2;
import '../../features/users/presentation/pages/users_page.dart';
part 'router_provider.g.dart';

final publicRoutes = [
  RoutePaths.homePath,
  RoutePaths.loginPath,
  RoutePaths.registerPath,
];

@riverpod
GoRouter appRouter(Ref ref) {
  
  final isLogin = ref.watch(
    authProvider.select((s) => s.isLogin),
  );

  return GoRouter(
    initialLocation: RoutePaths.homePath,
    redirect: (context, state) {

      final location = state.matchedLocation;

      // Usuario NO autenticado
      if (!isLogin) {
        print('entro condicoo');
        // Permitir navegar a rutas públicas
        if (publicRoutes.contains(location)) {
          return null;
        }

        // Cualquier otra ruta requiere login
        return RoutePaths.homePath;
      }

      // Usuario autenticado
      if (location == RoutePaths.homePath || 
          location == RoutePaths.loginPath ||
          location == RoutePaths.registerPath
      ) {
        return RoutePaths.dashboardPath;
      }

      return null;
    },
    routes: [

      GoRoute(
        name: RoutePaths.home,
        path: RoutePaths.homePath,
        pageBuilder: (context, state) => fadePage(HomePage())
      ),
      
      GoRoute(
        name: RoutePaths.login,
        path: RoutePaths.loginPath,
        pageBuilder: (context, state) => fadePage(AuthPage())
      ),

      GoRoute(
        name: RoutePaths.register,
        path: RoutePaths.registerPath,
        pageBuilder: (context, state) => fadePage(RegisterPage())
      ),

      ShellRoute(
        pageBuilder: (context, state, child) => fadePage(DashboardPage(child: child)),
        routes: [

          GoRoute(
            path: RoutePaths.dashboardPath,
            pageBuilder: (context, state) => fadePage(DashboardBody())
          ),

          GoRoute(
            name: RoutePaths.incidents,
            path: RoutePaths.incidentsPath,
            pageBuilder: (context, state) => fadePage(IncidentsPage()),
          ),

          GoRoute(
            name: RoutePaths.incidentDetail,
            path: RoutePaths.incidentDetailPath,
            pageBuilder: (context, state) { 
              final id = state.pathParameters['id'];
              return fadePage(IncidentDetailPage(id: int.parse( id ?? '-1' )));
            }
          ),

          GoRoute(
            path: RoutePaths.mapIncidentsPath,
            pageBuilder: (context, state) => fadePage(MapIncidents())
          ),

          GoRoute(
            path: RoutePaths.profilePath,
            pageBuilder: (context, state) => fadePage(MenuPage()),
          ),

          GoRoute(
            path: RoutePaths.usersPath,
            pageBuilder: (context, state) => fadePage(UsersPage()),
            routes: [
              GoRoute(
                name: RoutePaths.newUser,
                path: RoutePaths.newUserPath,
                pageBuilder: (context, state) => fadePage(NewUserPage())
              ),
            ]
          ),
          
          GoRoute(
            path: RoutePaths.reportsPath,
            pageBuilder: (context, state) => fadePage(ReportPage()),
          ),

          GoRoute(
            path: RoutePaths.entitiesPath,
            pageBuilder: (context, state) => fadePage(EntitiesPage()),
          ),
        ],
      ),

      GoRoute(
        name: RoutePaths.newIncident,
        path: RoutePaths.newIncidentPath,
        pageBuilder: (context, state) => fadePage(NewIncidentPage()),
        routes: [
          GoRoute(
            name: RoutePaths.photoPreview,
            path: RoutePaths.photoPreviewPath,
            pageBuilder: (context, state) => fadePage(PhotoPreviewPage())
          ),
          GoRoute(
            name: RoutePaths.analyzeIa,
            path: RoutePaths.analyzeIaPath,
            pageBuilder: (context, state) => fadePage(AnalyzeAiPage())
          ),
        ]
      ),
    ]
  );
}

CustomTransitionPage fadePage(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(opacity: animation,child: child);
    },
  );
}