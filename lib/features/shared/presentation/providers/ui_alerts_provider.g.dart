// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_alerts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UiAlerts)
final uiAlertsProvider = UiAlertsProvider._();

final class UiAlertsProvider
    extends $NotifierProvider<UiAlerts, AppErrorEntity?> {
  UiAlertsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uiAlertsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uiAlertsHash();

  @$internal
  @override
  UiAlerts create() => UiAlerts();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppErrorEntity? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppErrorEntity?>(value),
    );
  }
}

String _$uiAlertsHash() => r'bbc95205faa3371d67dbecb7cbba1ea9afbf825c';

abstract class _$UiAlerts extends $Notifier<AppErrorEntity?> {
  AppErrorEntity? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppErrorEntity?, AppErrorEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppErrorEntity?, AppErrorEntity?>,
              AppErrorEntity?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
