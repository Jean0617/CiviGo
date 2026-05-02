
import 'package:flutter/material.dart';
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

part 'router_provider.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {

  return GoRouter(
    initialLocation: RoutePaths.dashboardPath,
    redirect: (context, state) {
      return null;
    },
    routes: [

      GoRoute(
        name: RoutePaths.home,
        path: RoutePaths.homePath,
        builder: (_, __) => HomePage(),
      ),
      
      GoRoute(
        name: RoutePaths.login,
        path: RoutePaths.loginPath,
        builder: (_, __) => AuthPage(),
      ),

      GoRoute(
        name: RoutePaths.register,
        path: RoutePaths.registerPath,
        builder: (_, __) => RegisterPage(),
      ),


      ShellRoute(
        builder: (context, state, child) {
          return DashboardPage(child: child);
        },
        routes: [
          GoRoute(
            path: RoutePaths.dashboardPath,
            builder: (context, state) => DashboardBody(),
          ),
          GoRoute(
            path: RoutePaths.incidentsPath,
            builder: (context, state) => Center(child: Text('Incidencias')),
          ),
          GoRoute(
            path: RoutePaths.mapIncidentsPath,
            builder: (context, state) => MapIncidents(),
          ),
          GoRoute(
            path: RoutePaths.profilePath,
            builder: (context, state) => MenuPage(),
          ),
        ],
      ),

    ]
  );

}