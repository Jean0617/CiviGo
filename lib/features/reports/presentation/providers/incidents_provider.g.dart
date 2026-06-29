// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incidents_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Incidents)
final incidentsProvider = IncidentsProvider._();

final class IncidentsProvider
    extends $NotifierProvider<Incidents, IncidentsState> {
  IncidentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incidentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incidentsHash();

  @$internal
  @override
  Incidents create() => Incidents();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IncidentsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IncidentsState>(value),
    );
  }
}

String _$incidentsHash() => r'0b62797b76ac87607a086929a4f933ca868aa5ed';

abstract class _$Incidents extends $Notifier<IncidentsState> {
  IncidentsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<IncidentsState, IncidentsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IncidentsState, IncidentsState>,
              IncidentsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
