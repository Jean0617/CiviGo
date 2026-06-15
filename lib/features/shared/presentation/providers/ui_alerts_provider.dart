import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/app_error_entity.dart';

part 'ui_alerts_provider.g.dart';

@riverpod
class UiAlerts extends _$UiAlerts {

  @override
  AppErrorEntity? build() => null;

  void show(AppErrorEntity error) {
    state = error;
  }

  void clear() {
    state = null;
  }
}
