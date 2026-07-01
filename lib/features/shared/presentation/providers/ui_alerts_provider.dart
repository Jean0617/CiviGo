import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/app_error_entity.dart';

part 'ui_alerts_provider.g.dart';

@riverpod
class UiAlerts extends _$UiAlerts {

  Timer? _timer;

  @override
  AppErrorEntity? build() {

    ref.onDispose(() {
      _timer?.cancel();
    });

    return null;
  }

  void show(
    AppErrorEntity error, {
    Duration duration = const Duration(seconds: 5),
  }) {

    _timer?.cancel();

    state = error;

    _timer = Timer(duration, () {
      clear();
    });

  }

  void clear() {

    _timer?.cancel();

    state = null;

  }

}