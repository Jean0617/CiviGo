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
    extends $NotifierProvider<Incidents, List<Map<String, dynamic>>> {
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
  Override overrideWithValue(List<Map<String, dynamic>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Map<String, dynamic>>>(value),
    );
  }
}

String _$incidentsHash() => r'876f8209d579aba3700203e57424855805eb1ba8';

abstract class _$Incidents extends $Notifier<List<Map<String, dynamic>>> {
  List<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<List<Map<String, dynamic>>, List<Map<String, dynamic>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                List<Map<String, dynamic>>,
                List<Map<String, dynamic>>
              >,
              List<Map<String, dynamic>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
