import 'package:civigo/features/home/presentation/pages/home_page.dart';
import 'package:civigo/features/reports/presentation/pages/screens.dart';

import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config/route_config/route_paths.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
part 'router_provider.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {

  return GoRouter(
    initialLocation: RoutePaths.homePath,
    redirect: (context, state) {
      return null;
    },
    routes: [
      
      GoRoute(
        name: RoutePaths.login,
        path: RoutePaths.loginPath,
        builder: (_, __) => AuthPage(),
      ),

      GoRoute(
        name: RoutePaths.home,
        path: RoutePaths.homePath,
        builder: (_, __) => HomePage(),
      ),

      GoRoute(
        name: RoutePaths.report,
        path: RoutePaths.reportPath,
        builder: (_, __) => ReportPage(),//entra no me deja
      ),

      GoRoute(
        name: RoutePaths.reportSteps,
        path: RoutePaths.reportStepPath,
        builder: (_,__) => FlujoCrearReporte()
      )
      
    ]
  );

}