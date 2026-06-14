// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_incident_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NewIncident)
final newIncidentProvider = NewIncidentProvider._();

final class NewIncidentProvider
    extends $NotifierProvider<NewIncident, NewIncidentState> {
  NewIncidentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newIncidentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newIncidentHash();

  @$internal
  @override
  NewIncident create() => NewIncident();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NewIncidentState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NewIncidentState>(value),
    );
  }
}

String _$newIncidentHash() => r'fa5573f7eb392b3220279ede6691191404dc7352';

abstract class _$NewIncident extends $Notifier<NewIncidentState> {
  NewIncidentState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<NewIncidentState, NewIncidentState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NewIncidentState, NewIncidentState>,
              NewIncidentState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
