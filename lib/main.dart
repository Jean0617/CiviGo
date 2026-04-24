
import 'package:civigo/config/app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/app_config/theme/theme.dart';
import 'core/router/router_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: CiviGo()
    )
  );
}

class CiviGo extends ConsumerWidget {
  const CiviGo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final router = ref.read(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      routerConfig: router,
      theme: AppTheme.theme,
    );
  }
}
