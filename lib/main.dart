
import 'package:civigo/config/app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/app_config/theme/theme.dart';
import 'core/router/router_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://granzlvazcoimkwpzalf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdyYW56bHZhemNvaW1rd3B6YWxmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg2MjYwNzYsImV4cCI6MjA5NDIwMjA3Nn0.0yuMx75w-amcTBe3NJQGqfz24QLS5CirbXNRkEy3rJM',
  );

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

    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      routerConfig: router,
      theme: AppTheme.theme,
    );
  }
}
