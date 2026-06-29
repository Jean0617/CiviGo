// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IncidentDetail)
final incidentDetailProvider = IncidentDetailProvider._();

final class IncidentDetailProvider
    extends $NotifierProvider<IncidentDetail, IncidentDetailState> {
  IncidentDetailProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incidentDetailProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incidentDetailHash();

  @$internal
  @override
  IncidentDetail create() => IncidentDetail();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IncidentDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IncidentDetailState>(value),
    );
  }
}

String _$incidentDetailHash() => r'9bfb757f2ad08b0140e168c09206265e1b6590e9';

abstract class _$IncidentDetail extends $Notifier<IncidentDetailState> {
  IncidentDetailState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<IncidentDetailState, IncidentDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IncidentDetailState, IncidentDetailState>,
              IncidentDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
