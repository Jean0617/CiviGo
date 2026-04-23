import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../config/route_config/route_paths.dart';
import '../../features/auth/presentation/pages/auth_page.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {

  return GoRouter(
    initialLocation: RoutePaths.login,
    redirect: (context, state) {
      return null;
    },
    routes: [
      
      GoRoute(
        path: RoutePaths.login,
        builder: (_, __) => AuthPage(),
      ),

    ]
  );

}